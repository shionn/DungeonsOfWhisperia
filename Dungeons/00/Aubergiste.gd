extends PNJ

@onready var _food = $"../RDC/Bar/Food"

func _ready() -> void:
	$Character/Rig_Medium/Skeleton3D/AvianSwordsman_Cloak.hide()
	super._ready()

func interact() -> void:
	look_at_player()
	if tags.have(Tags.AUBERGE_PLAYER_RESTORED) :
		$"LookingForQuest/Mine Infestée".enable = tags.have(Tags.AUBERGE_PLAYER_KNOW_MINE_UNDEAD)
		$"LookingForQuest/Mission Accomplie/Next/Next/Next/La potion étrange".enable = bag.have(Items.ItemName.FioleNecrolisAttivae)
		gui.openDialog($LookingForQuest)
	elif _food.visible :
		gui.openDialog($Bienvenue/ApportFood)
	else :
		gui.openDialog($Bienvenue)


func _on_Bienvenue_close() -> void:
	gui.openTransition(_on_Bienvenue_close_transition_callback)

func _on_Bienvenue_close_transition_callback() -> void:
	_food.show()
	gui.openDialog($Bienvenue/ApportFood)


func _on_end_mission1_close() -> void:
	# TODO : retirer le crâne,
	# ajouter le tag
	# donner 8 pieces d'or
	pass # Replace with function body.
