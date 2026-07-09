@abstract class_name Monster
extends GameBaseCharacterBody3D 

enum State { IDLE, CHASE, ATTACK, ATTACKING, HIT, DEATH }

@onready var _animation = $"Character/AnimationPlayer" as AnimationPlayer
@onready var _navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var _animationTimer = $AnimationTimer as Timer
@onready var _atkTimer = $AtkTimer as Timer
@onready var _gcdTimer = $GcdTimer as Timer

@export var loot_obj : Items.ItemName = Items.ItemName.None
@export var loot_gold: int = 0
@export var lvl : int = 1

const _movement_speed: float = 4.0

var _atk : MonsterAtk
var _on_gcd : bool = false
var state : State = State.IDLE
var see_player = false
var pv = get_max_pv()
var _hit_take = 0

func _ready() -> void:
	_navigation_agent.target_desired_distance = 0 #_model.chase_distance
	start_animation("Idle_A")
	_atk = _find_atk()

func _physics_process(_delta: float) -> void:
	see_player = _see_player()
	if player.isDead() : 
		state = State.IDLE
	elif see_player or _hit_take>=2:
		_navigation_agent.set_target_position(player.global_position)
	match state: 
		State.CHASE:
			var distance = player.distance_to(self) 
			if _atk and distance < _atk.atk_range  or distance < get_min_atk_range() : # and _atk TODO
				state = State.ATTACK
			elif _navigation_agent.is_navigation_finished() : 
				state = State.IDLE
			else :
				_move_to_player()
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
	var start = global_position+Vector3.UP
	var end = player.global_position+Vector3.UP
	var direction = (end-start).normalized()
	var orientation = self.basis * Vector3.BACK
	if rad_to_deg(orientation.angle_to(direction)) <= get_fov() :
		var query = PhysicsRayQueryParameters3D.create(start, end)
		var result = get_world_3d().direct_space_state.intersect_ray(query)
		if (result && result.collider == player):
			return true
	return false

func _move_to_player() -> void :
	var next_path_position: Vector3 = _navigation_agent.get_next_path_position()
	self.look_at(next_path_position,Vector3.UP,true)
	self.rotation.x = 0
	self.velocity = global_position.direction_to(next_path_position) * _movement_speed
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
	_gcdTimer.start(get_global_colddown())
	_on_gcd = true
	state = State.ATTACKING

func _on_atk_timer_timeout() -> void:
	if state != State.DEATH :
		_atk.sound.play()
		player.receive_atk(_atk.damage(), self)
		_atk = null
		

func receive_atk(nb_atk: int) -> void:
	if state == State.DEATH : return
	_hit_take = _hit_take + 1
	var nb_def = Dices.d6(get_def(), 6)
	var deg = nb_atk - nb_def
	if nb_atk > 0 : gui.consoleLog("Vous obtenez %d 💀, %s obtient %d 🛡" % [nb_atk, name, nb_def])
	else :          gui.consoleLog("Vous obtenez %d 💀" % [nb_atk])
	if deg > 0 :
		pv = pv - deg
		get_hit_sound().play()
		if pv <= 0 :
			start_animation("Death_A", true)
			player.xp = player.xp+compute_xp()
			state = State.DEATH
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

@abstract func get_fov() -> float
@abstract func get_rig() -> String
@abstract func get_def() -> int
@abstract func get_hit_sound() -> AudioStreamPlayer3D
@abstract func get_max_pv() -> int
@abstract func is_large() -> bool
@abstract func get_global_colddown() -> float
@abstract func list_atks() -> Array[MonsterAtk]
@abstract func get_min_atk_range() -> int
