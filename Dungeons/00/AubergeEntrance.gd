extends GameBase3D

func _ready() -> void:
	if quest_book.auberge_01.start() : gui.openQuest()
	if quest_book.dungeon_01.is_done() and quest_book.auberge_02.start() : gui.openQuest()
		
