extends GridContainer


func open(description: Dialog) -> void:
	var context = $PanelContainer/MarginContainer/VBoxContainer/TabContainer/Context
	context.clear()
	context.append_text(description.text)
	show()

func _on_close_button_pressed() -> void:
	hide()
