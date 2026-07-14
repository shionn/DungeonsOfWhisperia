extends Interactable


func on_interact() -> void:
	if not tags.have(Tags.AUBERGE_PLAYER_RESTORED) :
		gui.openDialog($Description)
	elif not tags.have(Tags.DUNGEON_01_FINISHED): 
		$"Mission 1/Next".enable = bag.have(Items.ItemName.SkullHead)
		gui.openDialog($"Mission 1")
	else :
		gui.openDialog($"Rien")
		

func _on_mission_1_close() -> void:
	tags.add(Tags.DUNGEON_01_ENABLE)
