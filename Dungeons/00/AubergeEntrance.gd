extends GameBase3D

func _ready() -> void:
	if quest_book.auberge_01.start() : gui.openQuest()
	if quest_book.dungeon_01.is_done() and quest_book.auberge_02.start() : gui.openQuest()
	if quest_book.dungeon_02.is_done() and GAME_VERSION >= 0.3 and quest_book.auberge_03.start() : 
		if quest_book.dungeon_02_trouver_alliance.is_done() and not bag.have(Items.ItemName.Alliance) :
			quest_book.auberge_03_randre_alliance.done()
		gui.openQuest()

	gui.options.apply()
