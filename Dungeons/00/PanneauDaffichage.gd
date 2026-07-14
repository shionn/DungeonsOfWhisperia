extends Interactable


func on_interact() -> void:
	if not tags.have(Tags.AUBERGE_PLAYER_RESTORED) :
		gui.openDialog($Description)
	else : 
		$"Mission 1/Next".enable = bag.have(Items.ItemName.SkullHead)
		gui.openDialog($"Mission 1")

func _on_mission_1_close() -> void:
	tags.add(Tags.DUNGEON_01_ENABLE)
