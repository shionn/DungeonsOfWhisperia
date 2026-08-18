extends GameBase3D

func _ready() -> void:
	if quest_book.dungeon_03.start() : gui.openQuest()
