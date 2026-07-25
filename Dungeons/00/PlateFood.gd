extends Interactable

func on_interact() -> void:
	hide()
	player.pv = player.get_max_pv()
	quest_book.auberge_01_reprendre_des_forces.done()
	gui.consoleLog("Vous êtes rassasié et regagnez tous vos PV.")
