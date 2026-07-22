extends Interactable

func _ready() -> void:
	$AnimationPlayer.play("RigMedium/Death_B_Pose")
	$Rig_Medium/Skeleton3D/LeftHand/Bow.hide()
	$Rig_Medium/Skeleton3D/Ranger_Quiver.hide()
	$Rig_Medium/Skeleton3D/RightHand.hide()
	$Rig_Medium/Skeleton3D/Ranger_Cape.hide()
	super._ready()
	
