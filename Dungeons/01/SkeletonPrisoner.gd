extends Node3D

func _init() -> void:
	$Rig_Medium/Skeleton3D/RightHand/Skeleton_Blade.hide()
	$AnimationPlayer.play("RigMedium/Skeletons_Death_Pose")
