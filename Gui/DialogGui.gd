class_name DialogGui
extends GameBaseControl

@onready var _text = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/RichTextLabel as RichTextLabel
@onready var _pnj_view = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/SubViewportContainer as SubViewportContainer
@onready var _pnj_camera = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/SubViewportContainer/SubViewport/Camera3D as Camera3D
@onready var _close_button = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/CloseButton as Button
@onready var _option_button1 = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/OptionButton1 as Button
@onready var _option_button2 = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/OptionButton2 as Button
@onready var _option_button3 = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/OptionButton3 as Button
@onready var _option_button4 = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/OptionButton4 as Button
@onready var _next_button = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/NextButton as Button

var _current : Dialog

func _ready() -> void:
	hide()

func open(dialog: Dialog)->void :
	if dialog.text.is_empty() : 
		hide()
		dialog.activate.emit()
	else : 
		dialog.activate.emit()
		_current = dialog
		if dialog.close_enable : _close_button.show()
		else : _close_button.hide()
		_option_button1.hide()
		_option_button2.hide()
		_option_button3.hide()
		_option_button4.hide()
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
		
		if dialog.next and dialog.next.enable :
			_close_button.hide()
			_next_button.show()
		else :
			_add_option(dialog, _option_button1, 0)
			_add_option(dialog, _option_button2, 1)
			_add_option(dialog, _option_button3, 2)
			_add_option(dialog, _option_button4, 3)
		show()

func _add_option(dialog:Dialog, button : Button, id:int) -> void :
	if dialog.enabled_options().size() > id : 
		button.text = dialog.enabled_options()[id].label
		button.show()
	

func _on_close_button_pressed() -> void:
	#_current.close.emit()
	#_current = null
	hide()

func _on_next_button_pressed() -> void:
	_current.close.emit()
	var next = _current.next
	open(next)

func _on_option_button_1_pressed() -> void:
	_current.close.emit()
	var next = _current.enabled_options()[0]
	open(next)

func _on_option_button_2_pressed() -> void:
	_current.close.emit()
	var next = _current.enabled_options()[1]
	open(next)

func _on_option_button_3_pressed() -> void:
	_current.close.emit()
	var next = _current.enabled_options()[2]
	open(next)

func _on_option_button_4_pressed() -> void:
	_current.close.emit()
	var next = _current.enabled_options()[3]
	open(next)

func _on_visibility_changed() -> void:
	if not visible and _current :
		_current.close.emit()
