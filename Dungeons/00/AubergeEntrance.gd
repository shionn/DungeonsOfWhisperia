extends GameBase3D

func _ready() -> void:
	if quest_book.auberge_01.start() : gui.openQuest()
