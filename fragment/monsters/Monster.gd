class_name Monster
extends CharacterBody3D 

@onready var _player = $"../Player" as PlayerG
@onready var _animation = $"Character/AnimationPlayer" as AnimationPlayer
@onready var _navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var _atkTimer = $AtkTimer as Timer
@onready var _gcdTimer = $GcdTimer as Timer

@export_file("*.json") var model_file
var model : MonsterModel

enum Action { IDLE, CHASE, ATTACK, ATTACKING }

const _atk_dist = 2.0
const _chase_dist = 1.5
var movement_speed: float = 4.0

var _action : Action = Action.IDLE
var _on_gcd : bool = false



func _ready() -> void:
	model = MonsterModel.new(model_file, self)
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
				var atk : MonsterModelAtk = model.getAtk()
				if atk : 
					atk.start()
					_animation.play(atk.animation)
					_atkTimer.start(_animation.get_animation(atk.animation).length)
					_gcdTimer.start(model.global_cold_down)
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
	if rad_to_deg(orientation.angle_to(direction)) <= model.fov :
		var query = PhysicsRayQueryParameters3D.create(start, end)
		var result = get_world_3d().direct_space_state.intersect_ray(query)
		if (result && result.collider == _player):
			return true
	return false

func _move_to_player() -> void :
	var next_path_position: Vector3 = _navigation_agent.get_next_path_position()
	self.look_at(next_path_position,Vector3.UP,true)
	self.rotation.x=0
	self.velocity = global_position.direction_to(next_path_position) * movement_speed
	self._animation.play("Walking_A")

func _update_navigation() -> bool :
	if _see_player() :
		self._navigation_agent.set_target_position(_player.global_position)
	return self._navigation_agent.is_navigation_finished()

func _on_atk_timer_timeout() -> void:
	self._action = Action.CHASE
	# todo calculer l'impact joueur

func _on_gcd_timer_timeout() -> void:
	self._action = Action.CHASE
	_on_gcd = false
