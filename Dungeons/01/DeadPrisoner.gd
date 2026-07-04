extends Interactable

func _init() :
	$AnimationPlayer.play("RigMedium/Death_B_Pose")
	$Rig_Medium/Skeleton3D/Ranger_Cape.hide()
	$Rig_Medium/Skeleton3D/Ranger_Quiver.hide()
	$Rig_Medium/Skeleton3D/LeftHand.hide()
	$Rig_Medium/Skeleton3D/RightHand.hide()

	
	
