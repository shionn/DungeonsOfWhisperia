class_name Monster
extends CharacterBody3D 

enum Action { IDLE, CHASE, ATTACK, ATTACKING, HIT }

@onready var _player = $"../Player" as PlayerG
@onready var _animation = $"Character/AnimationPlayer" as AnimationPlayer
@onready var _navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var _animationTimer = $AnimationTimer as Timer
@onready var _gcdTimer = $GcdTimer as Timer

@export_file("*.json") var model_file

const _atk_dist = 2.0
const _chase_dist = 1.5
const _movement_speed: float = 4.0

var _model : MonsterModel
var _dices : Dices = Dices.new()
var _action : Action = Action.IDLE
var _on_gcd : bool = false

func _ready() -> void:
	_model = MonsterModel.new(model_file, self)
	_animation.get_animation("Idle").loop_mode = Animation.LOOP_LINEAR
	_animation.play("Idle")
	_navigation_agent.target_desired_distance = _chase_dist

func _physics_process(_delta: float) -> void:
	if _see_player() :
		_navigation_agent.set_target_position(_player.global_position)

	match _action: 
		Action.CHASE:
			var start = global_position
			var end = _player.global_position
			var distance = (end-start).length()
			if (distance < _atk_dist) :
				_action = Action.ATTACK
			elif _navigation_agent.is_navigation_finished() : 
				_action = Action.IDLE
			else :
				_move_to_player()
		Action.ATTACK:
			_look_player()
			if not _on_gcd :
				var atk : MonsterModelAtk = _model.getAtk()
				if atk : 
					atk.start()
					_animation.play(atk.animation)
					_animationTimer.start(_animation.get_animation(atk.animation).length)
					_gcdTimer.start(_model.global_cold_down)
					_on_gcd = true
					_action = Action.ATTACKING
			else : 
				_action = Action.IDLE
			velocity = Vector3.ZERO
		Action.ATTACKING:
			_look_player()
			velocity = Vector3.ZERO
		Action.IDLE:
			velocity = Vector3.ZERO
			_animation.play("Idle")
			if _see_player() :
				self._action = Action.CHASE
		Action.HIT:
			pass
		_:
			velocity = Vector3.ZERO
			_action = Action.IDLE
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
	self.rotation.x=0
	self.velocity = global_position.direction_to(next_path_position) * _movement_speed
	self._animation.play("Walking_A")

func _update_navigation() -> bool :
	if _see_player() :
		self._navigation_agent.set_target_position(_player.global_position)
	return self._navigation_agent.is_navigation_finished()

func receive_atk(nb_atk: int) -> void:
	var nb_def = _dices.d6(_model.def, 6)
	var deg = nb_atk - nb_def
	if deg > 0 :
		self._animation.play("Hit_A")
		self._animationTimer.start(_animation.get_animation("Hit_A").length)
		self._action = Action.HIT
		pass

func _on_animationTimer_timeout() -> void:
	match _action:
		Action.ATTACKING : self._action = Action.CHASE
		Action.HIT:
			_look_player()
			_action = Action.CHASE
		_: self._action = Action.IDLE
	# todo calculer l'impact joueur

func _on_gcd_timer_timeout() -> void:
	self._action = Action.CHASE
	_on_gcd = false
