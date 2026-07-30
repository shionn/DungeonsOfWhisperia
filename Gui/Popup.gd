extends GameBaseControl

func _ready() -> void:
	quest_book.quest_done.connect(_on_quest_done)

func _on_quest_done(quest : Quest) -> void :
	if quest == quest_book.dungeon_02 :
		show()

func _on_close_button_pressed() -> void:
	hide()
