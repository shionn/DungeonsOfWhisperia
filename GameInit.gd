class_name World
extends Node3D

@onready var cursor = load("res://assets/kenney/cursor-pack/pointer_c.png")
@onready var point_hand = load("res://assets/kenney/cursor-pack/hand_small_point.png")
@onready var drag = load("res://assets/kenney/cursor-pack/hand_closed.png")
@onready var can_drop = load("res://assets/kenney/cursor-pack/hand_open.png")

var target_monster: Monster = null

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(point_hand, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(drag, Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(can_drop, Input.CURSOR_CAN_DROP)

const _max_range: float = 20

func _physics_process(delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	var center = get_viewport().get_visible_rect().size/2
	var from = camera.project_ray_origin(center)
	var to = from + camera.project_ray_normal(center) * _max_range
	var query = PhysicsRayQueryParameters3D.create(from,to)
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	if result and result["collider"] is Monster: 
		target_monster = result["collider"]
	else : target_monster = null
