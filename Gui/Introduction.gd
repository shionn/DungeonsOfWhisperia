extends GameBaseControl

@onready var _quest_text : RichTextLabel = $PanelContainer/MarginContainer/VBoxContainer/TabContainer/Quete


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
		var text_objectif = "[ul]"
		var text_objectif_hidden = ""
		for objectif in quest.list_objectif() :
			if objectif.hidden and objectif.is_done() :
				text_objectif_hidden = text_objectif_hidden + "[s][color=gray]%s.[/color][/s]\n"%objectif.name
			if not objectif.hidden :
				if objectif.is_done() : text_objectif = text_objectif + "[s][color=gray]%s.[/color][/s]\n"%objectif.name
				else : text_objectif = text_objectif + "%s.\n"%objectif.name
		text_objectif = text_objectif + "[/ul]"
		_quest_text.append_text(text_objectif)
		if text_objectif_hidden :
			_quest_text.append_text("[i]Objectifs secondaires :[/i]")
			_quest_text.append_text("[ul]%s[/ul]"%text_objectif_hidden)
			
