class_name Monster
extends CharacterBody3D 

enum State { IDLE, CHASE, ATTACK, ATTACKING, HIT, DEATH }

@onready var _player = $/root/World/Player as PlayerG
@onready var _animation = $"Character/AnimationPlayer" as AnimationPlayer
@onready var _navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var _animationTimer = $AnimationTimer as Timer
@onready var _atkTimer = $AtkTimer as Timer
@onready var _gcdTimer = $GcdTimer as Timer
@onready var _gui = $/root/World/Gui as Gui

@export_file("*.json") var _model_file
@export var loot_obj : Items.ItemName = Items.ItemName.None
@export var loot_gold: int = 0

const _chase_dist = 1.5
const _movement_speed: float = 4.0

var _model : MonsterModel
var _atk : MonsterModelAtk
var _on_gcd : bool = false
var state : State = State.IDLE

func _ready() -> void:
	_model = MonsterModel.new(_model_file, self)
	_navigation_agent.target_desired_distance = _chase_dist
	start_animation("Idle_A")
	_atk = _model.get_atk()

func _physics_process(_delta: float) -> void:
	if _see_player() :
		_navigation_agent.set_target_position(_player.global_position)
	match state: 
		State.CHASE:
			var distance = (_player.global_position-global_position).length()
			if (_atk && distance < _atk.atk_range or distance < 2 and _player.pv>0) :
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
					_atk.start()
					start_animation(_atk.animation, true, _atkTimer, _atk.hit_factor)
					_gcdTimer.start(_model.global_cold_down)
					_on_gcd = true
					state = State.ATTACKING
				else :
					_atk = _model.get_atk()
					state = State.IDLE
			velocity = Vector3.ZERO
		State.ATTACKING:
			_look_player()
			velocity = Vector3.ZERO
		State.IDLE:
			velocity = Vector3.ZERO
			start_animation("Idle_A")
			if _see_player() :
				state = State.CHASE
		State.HIT, State.DEATH:
			pass
		_:
			velocity = Vector3.ZERO
			state = State.IDLE
	move_and_slide()

func _look_player() -> void :
	self.look_at(_player.global_position,Vector3.UP,true)
	self.rotation.x = 0

func _see_player() -> bool :
	var start = global_position+Vector3.UP
	var end = _player.global_position+Vector3.UP
	var direction = (end-start).normalized()
	var orientation = self.basis * Vector3.BACK
	if rad_to_deg(orientation.angle_to(direction)) <= _model.fov :
		var query = PhysicsRayQueryParameters3D.create(start, end)
		var result = get_world_3d().direct_space_state.intersect_ray(query)
		if (result && result.collider == _player):
			return true
	return false

func _move_to_player() -> void :
	var next_path_position: Vector3 = _navigation_agent.get_next_path_position()
	self.look_at(next_path_position,Vector3.UP,true)
	self.rotation.x = 0
	self.velocity = global_position.direction_to(next_path_position) * _movement_speed
	start_animation("Walking_A")

func _update_navigation() -> bool :
	if _see_player() :
		self._navigation_agent.set_target_position(_player.global_position)
	return self._navigation_agent.is_navigation_finished()

func start_animation(anim:String, time:bool=false, timer:Timer=null, timerFactor:float = 1.0) -> void:
	const _animation_prefix = "RigMediumAnimation/"
	_animation.play(_animation_prefix+anim)
	if time : 
		if timer :
			timer.start(_animation.get_animation(_animation_prefix+anim).length*timerFactor)
		else :
			_animationTimer.start(_animation.get_animation(_animation_prefix+anim).length*timerFactor)

func receive_atk(nb_atk: int) -> void:
	if state == State.DEATH : return
	var nb_def = Dices.d6(_model.def, 6)
	var deg = nb_atk - nb_def
	_gui.consoleLog("Vous obtenez %d 💀, %s obtient %d 🛡" % [nb_atk, name, nb_def])
	if deg > 0 :
		_model.pv = _model.pv - deg
		if _model.pv > 0 :
			if state != State.ATTACKING :
				start_animation("Hit_A", true)
				state = State.HIT
		else :
			start_animation("Death_A", true)
			state = State.DEATH
	else :
		_look_player()
		state = State.CHASE

func _on_animationTimer_timeout() -> void:
	match state:
		State.DEATH : 
			self.collision_layer = 256
			$CollisionDefault.disabled = true
			$CollisionDeath.disabled = false
		State.HIT:
			_look_player()
			state = State.CHASE
		_: 
			state = State.IDLE

func _on_gcd_timer_timeout() -> void:
	_on_gcd = false

func _on_atk_timer_timeout() -> void:
	if state != State.DEATH :
		_player.receive_atk(_atk.damage(), self)
		_atk = null
		if state == State.ATTACKING : state = State.CHASE
