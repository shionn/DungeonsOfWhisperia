extends GameBase3D

func _ready() -> void:
	if quest_book.dungeon_03.start() : gui.openQuest()
	if quest_book.dungeon_03_retrouver_compas.is_done() :
		$RoomSouthWest/Node3D/Desk/drafting_compass2.queue_free()

func _on_drafting_compass_loot() -> void:
	quest_book.dungeon_03_retrouver_compas.done()
