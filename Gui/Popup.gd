extends GameBaseControl

@onready var _text = $PanelContainer/MarginContainer/VBoxContainer/Text

func _ready() -> void:
	quest_book.quest_done.connect(_on_quest_done)

func _on_quest_done(quest : Quest) -> void :
	if quest == quest_book.dungeon_01 :
		_text.clear()
		_text.append_text($Donjon1.text)
		show()
	if quest == quest_book.dungeon_02 :
		_text.clear()
		_text.append_text($Donjon2.text)
		show()
	if quest == quest_book.dungeon_03 :
		_text.clear()
		_text.append_text($Donjon3.text)
		show()

func _on_close_button_pressed() -> void:
	hide()
