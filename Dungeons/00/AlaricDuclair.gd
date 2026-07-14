extends PNJ

func interact() -> void:
	look_at_player()
	gui.openDialog($"Présentation")
