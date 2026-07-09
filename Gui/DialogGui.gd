class_name DialogGui
extends GridContainer

@onready var _text = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/RichTextLabel as RichTextLabel
@onready var _pnj_view = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/SubViewportContainer as SubViewportContainer
@onready var _pnj_camera = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/SubViewportContainer/SubViewport/Camera3D as Camera3D

func _ready() -> void:
	hide()

func open(dialog: Dialog)->void :
	_text.clear()
	_text.append_text(dialog.text)
	if dialog.pnj : 
		_pnj_view.show()
		_pnj_camera.position = dialog.pnj.global_position + dialog.pnj.global_transform.basis*Vector3(.3,0,1) + Vector3(0,1.7,0)
		_pnj_camera.look_at(dialog.pnj.global_position + Vector3(0,1.7,0), Vector3.UP, false)
	else :
		_pnj_view.hide()
		
	show()


func _on_close_button_pressed() -> void:
	hide()
