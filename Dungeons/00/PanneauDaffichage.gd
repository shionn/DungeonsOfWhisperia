extends Interactable


func on_interact() -> void:
	if not quest_book.auberge_01_reprendre_des_forces.is_done() :
		gui.openDialog($Description)
	elif not tags.have(Tags.DUNGEON_01_FINISHED): 
		$"Mission 1/Next".enable = bag.have(Items.ItemName.SkullHead_Dungeon1)
		gui.openDialog($"Mission 1")
	else :
		gui.openDialog($"Rien")
		

func _on_mission_1_close() -> void:
	quest_book.auberge_01_trouver_kkchos_a_faire.done()
