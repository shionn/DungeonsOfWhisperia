extends CharacterBody3D 

@onready var _player = $"../Player" as PlayerG
@onready var _animation = $"Skeleton_Minion/AnimationPlayer" as AnimationPlayer
var _chasePlayer = false

func _ready() -> void:
	_animation.get_animation("Idle").loop_mode = Animation.LOOP_LINEAR
	_animation.play("Idle")
	

func _physics_process(delta: float) -> void:
	var start = global_position+Vector3.UP
	var end = _player.global_position+Vector3.UP
	var direction = (end-start).normalized()
	var orientation = self.basis * Vector3.BACK
	if rad_to_deg(orientation.angle_to(direction)) <= 60 :
		var query = PhysicsRayQueryParameters3D.create(start, end)
		var result = get_world_3d().direct_space_state.intersect_ray(query)
		if (result && result.collider == _player):
			print(self, "see player", result)
			self._chasePlayer = true
		else:
			self._chasePlayer = false
			pass
	if _chasePlayer : 
		self.look_at(end, Vector3.UP, true);
		self.rotation.x=0
