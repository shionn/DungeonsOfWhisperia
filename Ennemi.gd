extends CharacterBody3D



func _physics_process(delta: float) -> void:
	var start = global_position+Vector3.UP
	var end = $"../Player".global_position+Vector3.UP
	var direction = (end-start).normalized()
	var orientation = self.basis * Vector3.BACK
	if rad_to_deg(orientation.angle_to(direction)) <= 60 :
		var query = PhysicsRayQueryParameters3D.create(start, end)
		var result = get_world_3d().direct_space_state.intersect_ray(query)
		if (result && result.collider == $"../Player"):
			print(self, "see player", result)
		else:
			#print(self, "does not see player")
			pass
