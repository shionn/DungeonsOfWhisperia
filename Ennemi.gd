extends CharacterBody3D



func _physics_process(delta: float) -> void:
	var space_state = get_world_3d().direct_space_state
	var start = global_position+Vector3.UP
	var end = $"../Player".global_position+Vector3.UP
	print(start, " ", end)
	var query = PhysicsRayQueryParameters3D.create(start, end)
	var result = space_state.intersect_ray(query)
	print(result)
