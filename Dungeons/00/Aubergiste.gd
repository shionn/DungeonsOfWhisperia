extends PNJ

@onready var _food = $"../RDC/Bar/Food"

func _ready() -> void:
	$Character/Rig_Medium/Skeleton3D/AvianSwordsman_Cloak.hide()
	super._ready()

func interact() -> void:
	look_at_player()
	if tags.have(Tags.AUBERGE_PLAYER_RESTORED) :
		$"LookingForQuest/Service de l'auberge".enable = bag.gold >= 5

		$"LookingForQuest/Le Gouffre des Ombres".enable = tags.have(Tags.AUBERGE_PLAYER_KNOW_SHADOW_CHASM) and not tags.have(Tags.DUNGEON_02_ENABLE)
		$"LookingForQuest/Le Gouffre des Ombres/Next/Next".enable = tags.have(Tags.DUNGEON_01_FINISHED)

		$"LookingForQuest/Mission Accomplie".enable = bag.have(Items.ItemName.SkullHead_Dungeon1)
		$"LookingForQuest/Mission Accomplie/Next/Next/Next/La potion étrange".enable = bag.have(Items.ItemName.FioleNecrolisAttivae)
		gui.openDialog($LookingForQuest)
	elif _food.visible :
		gui.openDialog($Bienvenue/ApportFood)
	else :
		gui.openDialog($Bienvenue)


func _on_Bienvenue_close() -> void:
	gui.openTransition(func(): _food.show(), func(): gui.openDialog($Bienvenue/ApportFood))

func _on_end_mission1_close() -> void:
	bag.unloot(Items.ItemName.SkullHead_Dungeon1)
	tags.add(Tags.DUNGEON_01_FINISHED)
	bag.gold = bag.gold+8

func _on_manger_activate() -> void:
	var middle = func() : 
		bag.gold = bag.gold - 5
		_food.show()
	gui.openTransition(middle, func() : gui.openDialog($"LookingForQuest/Service de l'auberge/Manger/Next/Next/ApportFood"))

func _on_mine_infestee_next_activate() -> void:
	tags.add(Tags.DUNGEON_02_ENABLE)
