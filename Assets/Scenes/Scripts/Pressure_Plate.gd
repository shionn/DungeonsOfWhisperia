class_name PressurePlate
extends GameBase3D

@onready var _audio = $AudioStreamPlayer3D as AudioStreamPlayer3D
@onready var _floor = $floor_tile_small as Interactable

@export var listen_item : bool = true
@export var listen_player : bool = true 
@export var activate_by_player : bool = true 

enum Position {UP,DOWN,DOWN_DEEP}

var _position: Position = Position.UP

signal player_enter(plate: PressurePlate)
signal player_exit(plate: PressurePlate)
signal item_place(plate: PressurePlate, item: Item)

signal activate(plate: PressurePlate)

func toggle_down() -> void :
	_position = Position.DOWN
	_audio.play()
	_floor.position.y = 0
	activate.emit(self)

func toggle_down_deep() -> void :
	_position = Position.DOWN_DEEP
	_audio.play()
	_floor.position.y = -0.05

func toggle_up() -> void :
	_position = Position.UP
	_audio.play()
	_floor.position.y = 0.05

func is_empty() -> bool : return get_child_count() == 2
func is_toggle() -> bool : return _position == Position.DOWN

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is PlayerG and listen_player and is_empty():
		toggle_down()
		player_enter.emit(self)

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is PlayerG and listen_player and is_empty():
		toggle_up()
		player_exit.emit(self)

func _on_floor_tile_small_item_drop(item: Item) -> void:
	if listen_item and is_empty() : 
		item_place.emit(self, item)

func _on_child_exiting_tree(_node: Node) -> void:
	if _position != Position.UP : toggle_up()
