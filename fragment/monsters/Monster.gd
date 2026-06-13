class_name Monster
extends CharacterBody3D 

@onready var _player = $"../Player" as PlayerG
@onready var _animation = $"Character/AnimationPlayer" as AnimationPlayer
@onready var _navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var _atkTimer = $AtkTimer as Timer
@onready var _atkTimerDelay = $AtkDelay as Timer

@export_file("*.json") var model_file
var model : MonsterModel

enum Action { IDLE, CHASE, ATTACK, ATTACKING }

const _atk_dist = 2.0
const _chase_dist = 1.5
var movement_speed: float = 4.0

var _action : Action = Action.IDLE
var _can_atk : bool = true



func _ready() -> void:
	model = MonsterModel.new(model_file)
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
			if _can_atk :
				var delay = _animation.get_animation("1H_Melee_Attack_Chop").length
				_animation.play("1H_Melee_Attack_Chop")
				_atkTimer.start(delay)
				_atkTimerDelay.start(delay*2)
				_can_atk = false
				_action = Action.ATTACKING
			else : 
				_action = Action.IDLE
			velocity = Vector3.ZERO
		Action.ATTACKING:
			_look_player()
			velocity = Vector3.ZERO
		Action.IDLE:
			_search_player()
			_animation.play("Idle")
			velocity = Vector3.ZERO
		_:
			velocity = Vector3.ZERO
			_action = Action.IDLE

	move_and_slide()

func _look_player() -> void :
	self.look_at(_player.global_position,Vector3.UP,true)
	self.rotation.x = 0

func _search_player() -> float :
	var start = global_position+Vector3.UP
	var end = _player.global_position+Vector3.UP
	var distance = (end-start).length()
	var direction = (end-start).normalized()
	var orientation = self.basis * Vector3.BACK
	if rad_to_deg(orientation.angle_to(direction)) <= 60 :
		var query = PhysicsRayQueryParameters3D.create(start, end)
		var result = get_world_3d().direct_space_state.intersect_ray(query)
		if (result && result.collider == _player):
			self._action = Action.CHASE
			self._navigation_agent.set_target_position(result["position"])
		else:
			self._action = Action.IDLE
	return distance

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


func _on_atk_time_delay_timeout() -> void:
	print("can atk")
	self._can_atk = true
