class_name World
extends Node3D


var target_monster: Monster = null
var target_interactable: Interactable = null

const _max_range: float = 20

func _physics_process(_delta: float) -> void:
	_updateRayCast()
	#if Input.is_action_just_released("quit"):
	#	get_tree().quit()
	if Input.is_action_just_pressed("interact"):
		if target_interactable :
			target_interactable.on_interact()
	
func _updateRayCast() -> void : 
	var camera = get_viewport().get_camera_3d()
	var center = get_viewport().get_visible_rect().size/2
	var from = camera.project_ray_origin(center)
	var to = from + camera.project_ray_normal(center) * _max_range
	var query = PhysicsRayQueryParameters3D.create(from,to)
	query.collide_with_areas = true
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	if result and result["collider"] is Monster: 
		target_monster = result["collider"]
	else : target_monster = null
	if result and result["collider"] is Area3D and result["collider"].get_parent() is Interactable: 
		target_interactable = result["collider"].get_parent()
	else : target_interactable = null
