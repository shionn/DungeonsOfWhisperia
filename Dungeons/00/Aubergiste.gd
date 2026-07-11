extends PNJ


func _ready() -> void:
	$Character/Rig_Medium/Skeleton3D/AvianSwordsman_Cloak.hide()
	super._ready()

func interact() -> void:
	look_at_player()
	gui.openDialog($Bienvenue)
