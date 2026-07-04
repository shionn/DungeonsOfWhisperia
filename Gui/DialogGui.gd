class_name DialogGui
extends GridContainer

@onready var _text = $PanelContainer/MarginContainer/VBoxContainer/RichTextLabel as RichTextLabel

func _ready() -> void:
	hide()

func open(dialog: Dialog)->void :
	_text.clear()
	_text.append_text(dialog.text)
	show()


func _on_close_button_pressed() -> void:
	hide()
