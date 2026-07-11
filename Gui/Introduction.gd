extends GridContainer


func open(description: Dialog) -> void:
	var context = $PanelContainer/MarginContainer/VBoxContainer/TabContainer/Context
	context.clear()
	context.append_text(description.text)
	context.show()
	show()

func openHelp() -> void : 
	$PanelContainer/MarginContainer/VBoxContainer/TabContainer/Aide.show()
	show()

func _on_close_button_pressed() -> void:
	hide()
