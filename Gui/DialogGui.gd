class_name DialogGui
extends GridContainer

@onready var _text = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/RichTextLabel as RichTextLabel
@onready var _pnj_view = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/SubViewportContainer as SubViewportContainer
@onready var _pnj_camera = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/SubViewportContainer/SubViewport/Camera3D as Camera3D
@onready var _close_button = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/CloseButton as Button
@onready var _option_button1 = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/OptionButton1 as Button

var _option1 : Callable

func _ready() -> void:
	hide()

func open(dialog: Dialog)->void :
	_close_button.show()
	_option_button1.hide()
	
	_text.clear()
	if dialog.pnj : _text.append_text("[color=gray]%s : [/color]"%dialog.pnj.name)
	else : _text.append_text("[color=gray]Vous : [/color]")
	_text.append_text(dialog.text)
	if dialog.pnj : 
		_pnj_view.show()
		_pnj_camera.position = dialog.pnj.global_position + dialog.pnj.global_transform.basis*Vector3(.3,0,1) + Vector3(0,1.7,0)
		_pnj_camera.look_at(dialog.pnj.global_position + Vector3(0,1.7,0), Vector3.UP, false)
	else :
		_pnj_view.hide()
	
	if dialog.next :
		_close_button.hide()
		_option_button1.show()
		_option_button1.text = "Suite"
		_option1 = func() : open(dialog.next)
		
		
	
		
	show()


func _on_close_button_pressed() -> void:
	hide()


func _on_option_button_1_pressed() -> void:
	_option1.call()
