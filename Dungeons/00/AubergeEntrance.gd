extends GameBase3D

func _ready() -> void:
	if not tags.have(Tags.AUBERGE_PLAYER_RESTORED): gui.openHelp($Quest0)
