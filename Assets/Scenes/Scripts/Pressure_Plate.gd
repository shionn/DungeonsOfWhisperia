class_name PressurePlate
extends GameBase3D

@onready var _audio = $AudioStreamPlayer3D as AudioStreamPlayer3D
@onready var _floor = $floor_tile_small as Interactable

@export var listen_item : bool = true
@export var listen_player : bool = true 
@export var expected_item : Items.ItemName = Items.ItemName.None
@export var activate_by_player : bool = true 

signal player_enter(plate: PressurePlate)
signal player_exit(plate: PressurePlate)
signal item_place(plate: PressurePlate, item: Item)

signal activate(plate: PressurePlate)

func toggle_down() -> void :
	_audio.play()
	_floor.position.y = 0

func toggle_down_deep() -> void :
	_audio.play()
	_floor.position.y = -0.05

func toggle_up() -> void :
	_audio.play()
	_floor.position.y = 0.05

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is PlayerG and listen_player :
		toggle_down()
		player_enter.emit(self)
		if activate_by_player : activate.emit(self)


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is PlayerG and listen_player :
		toggle_up()
		player_exit.emit(self)


func _on_floor_tile_small_item_drop(item: Item) -> void:
	pass
