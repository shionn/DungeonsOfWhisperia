extends Node3D

const _ANGLE = deg_to_rad(30)

signal state_change(state:bool);

var _state = false :
	set(value):
		_state = value
		state_change.emit(_state)

func _ready() -> void:
	rotation.z = _ANGLE

func _on_screwdriver_activate() -> void:
	_state = !_state
	if _state : rotation.z = -_ANGLE
	else : rotation.z = _ANGLE
