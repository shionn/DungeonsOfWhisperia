extends GameBase3D

func _ready() -> void:
	quest_book.auberge_01.start()
	if not quest_book.auberge_01_reprendre_des_forces.is_done() : gui.openHelp($Quest0)
