extends Node

@onready var cursor = load("res://Gui/Assets/kenney/cursor-pack/pointer_c.png")
@onready var point_hand = load("res://Gui/Assets/kenney/cursor-pack/hand_point.png")
@onready var drag = load("res://Gui/Assets/kenney/cursor-pack/hand_closed.png")
@onready var can_drop = load("res://Gui/Assets/kenney/cursor-pack/hand_open.png")

func _ready() -> void:
	Input.warp_mouse(get_viewport().get_visible_rect().size/2)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Input.set_custom_mouse_cursor(cursor,     Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(point_hand, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(drag,       Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(can_drop,   Input.CURSOR_CAN_DROP)


func _on_character_select(model: String) -> void:
	print(model)
	get_tree().change_scene_to_file("res://World.tscn")
