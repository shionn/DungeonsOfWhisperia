extends PNJ

func interact() -> void:
	look_at_player()
	if tags.have(Tags.AUBERGE_PLAYER_RESTORED) : gui.openDialog($Bievenue_Restored)
	else : gui.openDialog($Bienvenue)
