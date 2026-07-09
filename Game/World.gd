class_name World
extends GameBase3D


var target_monster: Monster = null
var target_interactable: Interactable = null
var target_pnj: PNJ = null

const _max_range: float = 20

func _physics_process(_delta: float) -> void:
	_updateRayCast()
	#if Input.is_action_just_released("quit"):
	#	get_tree().quit()
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and Input.is_action_just_pressed("interact") and not player.isDead():
		if target_interactable and target_interactable.is_in_range():
			target_interactable.on_interact()
		if target_monster and target_monster.is_dead() and target_monster.is_in_loot_range() :
			gui.openLoot(target_monster)
		if target_pnj and target_pnj.is_in_range():
			target_pnj.interact()
	
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
	if result and result["collider"] is Area3D and result["collider"].get_parent() is Interactable : 
		target_interactable = result["collider"].get_parent()
	else : target_interactable = null
	if result and result["collider"] is PNJ: 
		target_pnj = result["collider"]
	else : target_pnj = null
