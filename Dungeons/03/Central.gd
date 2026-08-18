extends GameBase3D

@onready var _south_east_light = $wall_inset5/skull/Ruby_022/LootVFX_Mythic
@onready var _south_west_light = $wall_inset4/skull/Topaz_012/LootVFX_Legendary
@onready var _north_east_light = $wall_inset3/skull/Sapphire_012/LootVFX_Rare
@onready var _north_west_light = $wall_inset2/skull/Emerald_022/LootVFX_Uncommon

@onready var _portal = $GatePortalVFX_06

func _ready() -> void:
	_south_east_light.visible = quest_book.dungeon_03_resoudre_jetons.is_done()
	_south_west_light.visible = quest_book.dungeon_03_resoudre_engrenage.is_done()
	_north_east_light.visible = quest_book.dungeon_03_resoudre_lumiere.is_done()
	_north_west_light.visible = quest_book.dungeon_03_resoudre_dalles.is_done()
	if quest_book.dungeon_03_faire_tomber_le_champ_de_force.is_done() :
		_portal.queue_free()
	quest_book.objectif_done.connect(_on_objectif_done)

func _on_objectif_done(_quest: Quest, objectif: QuestObjectif) -> void : 
	if objectif == quest_book.dungeon_03_resoudre_jetons : _south_east_light.show()
	if objectif == quest_book.dungeon_03_resoudre_engrenage : _south_west_light.show()
	if objectif == quest_book.dungeon_03_resoudre_lumiere : _north_east_light.show()
	if objectif == quest_book.dungeon_03_resoudre_dalles : _north_west_light.show()
	_test_all()


func _test_all() -> void : 
	if _south_east_light.visible and _south_west_light.visible and _north_east_light.visible and _north_west_light.visible :
		if _portal : 
			_portal.queue_free()
			_portal = null
			quest_book.dungeon_03_faire_tomber_le_champ_de_force.done()
