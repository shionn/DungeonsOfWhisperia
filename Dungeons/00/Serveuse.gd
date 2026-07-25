extends PNJ

func interact() -> void:
	look_at_player()
	_animation.play("RigMedium/Waving")
	_animation.queue("RigMedium/Idle_A")
	if quest_book.auberge_01_reprendre_des_forces.is_done() : 
		$"Bievenue_Restored/Mission Accomplie".enable = bag.have(Items.ItemName.SkullHead_Dungeon1)
		gui.openDialog($Bievenue_Restored)
	else : gui.openDialog($Bienvenue)
