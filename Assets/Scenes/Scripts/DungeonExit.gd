extends Interactable

func on_interact() -> void:
	bag.unloot_not_global()
	gui.openDungeonExit()
