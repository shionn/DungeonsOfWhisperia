extends PNJ

func interact() -> void:
	look_at_player()
	$"Présentation/Next/Valthorion ?".enable = tags.have(Tags.AUBERGE_PLAYER_KNOW_VALTHORION)
	gui.openDialog($"Présentation")
