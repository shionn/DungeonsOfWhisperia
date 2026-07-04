extends PlayerG


func _ready() -> void:
	$Character/Rig_Medium/Skeleton3D/RogueHooded_Head.hide()
	$Character/Rig_Medium/Skeleton3D/RogueHooded_Mask.hide()
	super._ready()

func get_def(): return 2
