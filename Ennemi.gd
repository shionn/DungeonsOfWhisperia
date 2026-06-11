extends CharacterBody3D 

@onready var _player = $"../Player" as PlayerG
@onready var _animation = $"Skeleton_Minion/AnimationPlayer" as AnimationPlayer
@onready var _navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var _atkTimer= $AtkTimer as Timer

enum Action { IDLE, CHASE, ATTACK, ATTACKING }

const _atk_dist = 2.0
const _chase_dist = 1.5
var movement_speed: float = 4.0

var _action : Action = Action.IDLE

func _ready() -> void:
	_animation.get_animation("Idle").loop_mode = Animation.LOOP_LINEAR
	_animation.play("Idle")
	_navigation_agent.target_desired_distance = _chase_dist

func _physics_process(delta: float) -> void:
	_search_player()
	match _action: 
		Action.CHASE:
			var next_path_position: Vector3 = _navigation_agent.get_next_path_position()
			self.look_at(next_path_position,Vector3.UP,true)
			self.rotation.x=0
			velocity = global_position.direction_to(next_path_position) * movement_speed
			_animation.play("Walking_A")
		Action.ATTACK:
			_animation.play("1H_Melee_Attack_Chop")
			_atkTimer.start(_animation.get_animation("1H_Melee_Attack_Chop").length)
			_action = Action.ATTACKING
			velocity = Vector3.ZERO
		Action.ATTACKING:
			velocity = Vector3.ZERO
		Action.IDLE:
			_animation.play("Idle")
			velocity = Vector3.ZERO
		_:
			velocity = Vector3.ZERO
			_action = Action.IDLE
			

	move_and_slide()

func _search_player() -> void :
	var start = global_position+Vector3.UP
	var end = _player.global_position+Vector3.UP
	var direction = (end-start).normalized()
	var orientation = self.basis * Vector3.BACK
	if rad_to_deg(orientation.angle_to(direction)) <= 60 :
		var query = PhysicsRayQueryParameters3D.create(start, end)
		var result = get_world_3d().direct_space_state.intersect_ray(query)
		if (result && result.collider == _player):
			#print(self, "see player", result)
			self.look_at(end,Vector3.UP,true)
			self.rotation.x = 0
			if _action != Action.ATTACKING :
				if (end-start).length()>_atk_dist :
					self._action = Action.CHASE
					_navigation_agent.set_target_position(result["position"])
				else :
					self._action = Action.ATTACK
		else:
			self._action = Action.IDLE


func _on_atk_timer_timeout() -> void:
	print("end timer")
	self._action = Action.CHASE
