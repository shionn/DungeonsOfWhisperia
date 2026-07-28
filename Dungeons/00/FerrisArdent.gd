extends PNJ


func _ready() -> void:
	$Character/Rig_Medium/Skeleton3D/Engineer_Backpack.queue_free()
	$Character/Rig_Medium/Skeleton3D/RightHand/engineer_Wrench2.queue_free()
	$Character/Rig_Medium/Skeleton3D/Engineer_Goggles.queue_free()
	super._ready()

func interact() -> void:
	look_at_player()
	if quest_book.auberge_01_reprendre_des_forces.is_done() :
		gui.openDialog($Dialog)
	else :
		gui.openDialog($"DialogueJoueurFatigué")
