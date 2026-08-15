extends GameBase3D

func _ready() -> void:
	if quest_book.dungeon_02.start() : gui.openQuest()
	if not quest_book.dungeon_02_preuve_kill_boss.is_done() :
		$"BossRoom/Skeleton Golem".loot_obj = Items.ItemName.SkullHead_Dungeon2
	if quest_book.dungeon_02_preuve_valthorion.is_done() :
		$BossRoom/Desk/ValthorionRing.queue_free()
	if quest_book.dungeon_02_trouver_aliance.is_done() :
		$RitualRoom/Ranger.queue_free()
	
	bag.item_loot.connect(_on_item_loot)
	options.apply()


func _on_item_loot(item : Item) -> void :
	if item.item_name == Items.ItemName.Alliance :
		quest_book.dungeon_02_trouver_alliance.done()
	if item.item_name == Items.ItemName.SkullHead_Dungeon2 :
		quest_book.dungeon_02_preuve_kill_boss.done()
	if item.item_name == Items.ItemName.AnneauValthorion :
		quest_book.dungeon_02_preuve_valthorion.done()

func _on_skeleton_golem_dead() -> void:
	quest_book.dungeon_02_kill_boss.done()

func _on_tomb_description_close() -> void:
	quest_book.dungeon_02_identifier_valthorion.done()

func _on_ritual_tomb_description_close() -> void:
	quest_book.dungeon_02_trouver_nom_aelthara.done()
