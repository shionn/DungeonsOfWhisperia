@abstract class_name Monster
extends GameBaseCharacterBody3D 

enum State { IDLE, CHASE, ATTACK, ATTACKING, HIT, DEATH, PATROL, NAVIGATE }

@onready var _animation = $"Character/AnimationPlayer" as AnimationPlayer
@onready var _navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var _animationTimer = $AnimationTimer as Timer
@onready var _atkTimer = $AtkTimer as Timer
@onready var _offHandAtkTimer = $OffHandAtkTimer as Timer
@onready var _gcdTimer = $GcdTimer as Timer

@export var state : State = State.IDLE 
@export var lvl : int = 1
@export_category("loot")
@export var loot_obj : Items.ItemName = Items.ItemName.None
@export var loot_gold: int = 0
@export_category("patrol")
@export var patrol_path : Array[Vector3] = []
@export var walk_speed : float = 1.5

signal dead()

const _movement_speed: float = 4.0

var _atk : MonsterAtk
var _on_gcd : bool = false
var see_player = false
var pv = get_max_pv()
var _hit_take = 0
var _patrol_target = 0

func _ready() -> void:
	_navigation_agent.target_desired_distance = 0
	start_animation("Idle_A")
	_atk = _find_atk()
	add_to_group("Monsters")
	#_offHandAtkTimer.timeout.connect(self._on_off_hand_atk_timers_timeout)
	if state == State.PATROL : _navigation_agent.set_target_position(patrol_path[0])

func _physics_process(_delta: float) -> void:
	see_player = _see_player()
	if player.isDead() : 
		state = State.IDLE
	elif state != State.NAVIGATE and (see_player or _hit_take>=2):
		_navigation_agent.set_target_position(player.global_position)
		if state == State.IDLE : state = State.CHASE
	match state: 
		State.CHASE:
			var distance = player.distance_to(self) 
			if _atk and distance < _atk.atk_range  or distance < get_min_atk_range() : # and _atk TODO
				state = State.ATTACK
			elif _navigation_agent.is_navigation_finished() : 
				state = State.IDLE
			else :
				_move_to_navigation()
		State.NAVIGATE :
			if _navigation_agent.is_navigation_finished() :
				velocity = Vector3.ZERO
			else :
				_move_to_navigation()
		State.PATROL :
			if see_player : state = State.CHASE
			elif _navigation_agent.is_navigation_finished() :
				_patrol_target = _patrol_target +1
				if _patrol_target>=patrol_path.size() : _patrol_target = 0
				_navigation_agent.set_target_position(patrol_path[_patrol_target])
			else : _move_to_navigation()
		State.ATTACK:
			if _on_gcd : 
				state = State.IDLE
			else :
				if _atk :
					_start_atk()
				else :
					_atk = _find_atk()
					state = State.IDLE
			velocity = Vector3.ZERO
		State.ATTACKING:
			_look_player()
			velocity = Vector3.ZERO
		State.IDLE:
			velocity = Vector3.ZERO
			start_animation("Idle_A")
			if see_player:
				state = State.CHASE
		State.HIT, State.DEATH:
			velocity = Vector3.ZERO
		_:
			velocity = Vector3.ZERO
			state = State.IDLE
	move_and_slide()

func _look_player() -> void :
	self.look_at(player.global_position,Vector3.UP,true)
	self.rotation.x = 0

func _see_player() -> bool :
	var start = global_position+Vector3.UP*2
	var end = player.global_position+Vector3.UP*2
	var direction = (end-start).normalized()
	var orientation = self.basis * Vector3.BACK
	var fov = get_fov()
	if state == State.PATROL : fov = fov-20;
	if rad_to_deg(orientation.angle_to(direction)) <= get_fov() :
		var query = PhysicsRayQueryParameters3D.create(start, end, 1)
		var result = get_world_3d().direct_space_state.intersect_ray(query)
		if (result && result.collider == player):
			return true
	return false

func _move_to_navigation() -> void :
	var next_path_position: Vector3 = _navigation_agent.get_next_path_position()
	if next_path_position != global_position :
		self.look_at(next_path_position,Vector3.UP,true)
	self.rotation.x = 0
	self.velocity = global_position.direction_to(next_path_position)
	if state == State.PATROL or state == State.NAVIGATE : velocity = velocity * walk_speed 
	else : velocity = velocity * _movement_speed
	start_animation("Walking_A")

func _update_navigation() -> bool :
	if see_player :
		self.navigation_agent.set_target_position(player.global_position)
	return self._navigation_agent.is_navigation_finished()

func start_animation(anim:String, time:bool=false, timer:Timer=null, timerFactor:float = 1.0) -> void:
	_animation.play(get_rig()+anim)
	if time : 
		if timer :
			timer.start(_animation.get_animation(get_rig()+anim).length*timerFactor)
		else :
			_animationTimer.start(_animation.get_animation(get_rig()+anim).length*timerFactor)

func _on_animationTimer_timeout() -> void:
	match state:
		State.DEATH : 
			self.collision_layer = 256
			$CollisionDefault.disabled = true
			$CollisionDeath.disabled = false
		State.ATTACKING :
			if state != State.DEATH : state = State.CHASE
		State.HIT:
			_look_player()
			state = State.CHASE
		_: 
			state = State.IDLE

func _find_atk() -> MonsterAtk :
	var _atks = list_atks()
	var atk = _atks[Dices._random.randi_range(0,_atks.size()-1)]
	if not atk.on_cold_down:
		return atk
	return null

func _start_atk() -> void:
	var anim_name = get_rig() + _atk.animation
	var length = _animation.get_animation(anim_name).length
	_animation.play(anim_name)
	_animationTimer.start(length)
	_atk.start()
	_atkTimer.start(length*_atk.animation_to_hit_factor)
	if _atk.dual_hand : _offHandAtkTimer.start(length*_atk.off_hand_animation_to_hit_factor)
	_gcdTimer.start(get_global_colddown())
	_on_gcd = true
	state = State.ATTACKING

func _on_atk_timer_timeout() -> void:
	if state != State.DEATH :
		_atk.sound.play()
		player.receive_atk(_atk.damage(), self)
		if not _atk.dual_hand :
			_atk = null

func _on_off_hand_atk_timers_timeout() -> void:
	if state != State.DEATH :
		_atk.sound.play()
		player.receive_atk(_atk.off_hand_damage(), self)
		_atk = null

func receive_atk(nb_atk: int) -> void:
	if state == State.DEATH : return
	_hit_take = _hit_take + 1
	var nb_def = Dices.d6(get_def(), 6)
	var deg = nb_atk - nb_def
	if nb_atk > 0 : 
		#gui.consoleLog("Vous obtenez %d 💀, %s obtient %d 🛡" % [nb_atk, name, nb_def])
		var label : Node3D = preload("res://Game/StateLabel.tscn").instantiate()
		label.set_text("%d💀/%d🛡"%[nb_atk, nb_def])
		add_child(label)
	else :
		#gui.consoleLog("Vous obtenez %d 💀" % [nb_atk])
		var label : Node3D = preload("res://Game/StateLabel.tscn").instantiate()
		label.set_text("%d💀"%[nb_atk, nb_def])
		add_child(label)
	if deg > 0 :
		pv = pv - deg
		get_hit_sound().play()
		if pv <= 0 :
			start_animation("Death_A", true)
			player.xp = player.xp+compute_xp()
			state = State.DEATH
			dead.emit()
		elif state != State.ATTACKING :
			start_animation("Hit_A", true)
			state = State.HIT
	elif state != State.ATTACKING  :
		_look_player()
		state = State.CHASE

func _on_gcd_timer_timeout() -> void:
	_on_gcd = false

func compute_xp() -> int:
	var large = 1 if is_large() else 0
	return get_def()+get_max_pv()+list_atks().get(0).atk_dice+lvl+large

func is_in_loot_range() -> bool : return distance_to(player) <= LOOT_RANGE 
func is_dead() -> bool : return state == Monster.State.DEATH

func navitage_to(pos: Vector3) -> void:
	_navigation_agent.set_target_position(pos)
	state = State.NAVIGATE

@abstract func get_fov() -> float
@abstract func get_rig() -> String
@abstract func get_def() -> int
@abstract func get_hit_sound() -> AudioStreamPlayer3D
@abstract func get_max_pv() -> int
@abstract func is_large() -> bool
@abstract func get_global_colddown() -> float
@abstract func list_atks() -> Array[MonsterAtk]
@abstract func get_min_atk_range() -> int
