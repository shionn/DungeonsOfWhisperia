extends MenuButton

func _ready() -> void:
	visible = false
	get_popup().id_pressed.connect(_on_id_pressed)

func _on_id_pressed(id: int) -> void:
	match id :
		0: get_tree().quit()
		1: $"/root/World/Player".save_game()
		2: $"../Options".show()
		3: $"../Introduction".openHelp()
