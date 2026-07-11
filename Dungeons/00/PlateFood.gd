extends Interactable

func on_interact() -> void:
	hide()
	player.pv = player.get_max_pv()
	tags.add(Tags.AUBERGE_RESTORED)
	gui.consoleLog("Vous êtes rassasié et regagnez tous vos PV.")
