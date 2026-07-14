extends PNJ

func interact() -> void:
	look_at_player()
	_animation.play("RigMedium/Waving")
	_animation.queue("RigMedium/Idle_A")
	if tags.have(Tags.AUBERGE_PLAYER_RESTORED) : 
		$"Bievenue_Restored/Mission Accomplie".enable = bag.have(Items.ItemName.SkullHead)
		gui.openDialog($Bievenue_Restored)
	else : gui.openDialog($Bienvenue)
