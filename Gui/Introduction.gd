extends GameBaseControl

@onready var _quest_text : RichTextLabel = $PanelContainer/MarginContainer/VBoxContainer/TabContainer/Quete


func open(description: Dialog) -> void:
	var context = $PanelContainer/MarginContainer/VBoxContainer/TabContainer/Context
	context.clear()
	context.append_text(description.text)
	context.show()
	show()

func openHelp() -> void : 
	$PanelContainer/MarginContainer/VBoxContainer/TabContainer/Aide.show()
	show()

func openQuest() -> void : 
	$PanelContainer/MarginContainer/VBoxContainer/TabContainer/Quete.show()
	show()

func _on_close_button_pressed() -> void:
	hide()


func _on_quete_visibility_changed() -> void:
	if _quest_text.visible and quest_book and quest_book.current : 
		_update_quest_text(quest_book.current)

func _update_quest_text(quest : Quest = null) -> void : 
		_quest_text.clear()
		_quest_text.append_text(quest.description)
		_quest_text.newline()
		_quest_text.newline()
		_quest_text.append_text("[i]Objectifs : %s[/i]"%quest.title)
		var obj = "[ul]"
		for objectif in quest.list_objectif() :
			if objectif.is_done() : obj = obj + "[s][color=gray]%s.[/color][/s]\n"%objectif.name
			else : obj = obj + "%s.\n"%objectif.name
		obj = obj + "[/ul]"
		_quest_text.append_text(obj)
