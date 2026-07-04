extends Node3D

func _ready() -> void:
	$Area3D.connect("mouse_enter",_mouse_enter)
	$Area3D.connect("mouse_exited",_mouse_exit)
	
	
func _mouse_enter() -> void :
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _mouse_exit() -> void :
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
