extends TextureRect

func _physics_process(delta: float) -> void:
	visible = Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
