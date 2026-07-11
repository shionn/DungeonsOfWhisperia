class_name DialogGui
extends GridContainer

@onready var _text = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/RichTextLabel as RichTextLabel
@onready var _pnj_view = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/SubViewportContainer as SubViewportContainer
@onready var _pnj_camera = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/SubViewportContainer/SubViewport/Camera3D as Camera3D
@onready var _close_button = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/CloseButton as Button
@onready var _option_button1 = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/OptionButton1 as Button
@onready var _next_button = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/NextButton as Button

var _current : Dialog

func _ready() -> void:
	hide()

func open(dialog: Dialog)->void :
	_current = dialog
	_close_button.show()
	_option_button1.hide()
	_next_button.hide()
	
	_text.clear()
	if dialog.pnj : _text.append_text("[color=darkgray]%s : [/color]"%dialog.pnj.name)
	else : _text.append_text("[color=darkgray]Vous : [/color]")
	_text.append_text(dialog.text)
	if dialog.pnj : 
		_pnj_view.show()
		_pnj_camera.position = dialog.pnj.global_position + dialog.pnj.global_transform.basis*Vector3(.3,0,1) + Vector3(0,1.7,0)
		_pnj_camera.look_at(dialog.pnj.global_position + Vector3(0,1.7,0), Vector3.UP, false)
	else :
		_pnj_view.hide()
	
	if dialog.next :
		_close_button.hide()
		_next_button.show()
	show()


func _on_close_button_pressed() -> void:
	_current.close.emit()
	hide()

func _on_next_button_pressed() -> void:
	_current.close.emit()
	open(_current.next)

func _on_option_button_1_pressed() -> void:
	pass
