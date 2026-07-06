extends Node

@onready var cursor = load("res://Gui/Assets/kenney/cursor-pack/pointer_c.png")
@onready var point_hand = load("res://Gui/Assets/kenney/cursor-pack/hand_point.png")
@onready var drag = load("res://Gui/Assets/kenney/cursor-pack/hand_closed.png")
@onready var can_drop = load("res://Gui/Assets/kenney/cursor-pack/hand_open.png")
@onready var forbidden = load("res://Gui/Assets/kenney/cursor-pack/disabled.png")

func _ready() -> void:
	var pos = get_viewport().get_visible_rect().size/2;
	pos.y = pos.y-100;
	Input.warp_mouse(pos)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Input.set_custom_mouse_cursor(cursor,     Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(point_hand, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(drag,       Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(can_drop,   Input.CURSOR_CAN_DROP)
	Input.set_custom_mouse_cursor(forbidden,  Input.CURSOR_FORBIDDEN)


func _on_character_select(model: String) -> void:
	var world = preload("res://World.tscn").instantiate()
	#var dungeon = preload("res://Dungeons/01/Dungeon01.tscn").instantiate()
	var dungeon = preload("res://Dungeons/00/Auberge.tscn").instantiate()
	dungeon.name = "Dungeon"
	var player = load("res://Game/Player/%s.tscn"%model).instantiate()
	world.add_child(player);
	world.add_child(dungeon);
	get_tree().change_scene_to_node(world)
