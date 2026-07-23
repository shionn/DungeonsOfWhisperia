extends GridContainer

@onready var _scale_label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Scale
@onready var _scale_mode_button = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/GridContainer/ScaleModeButton

func _ready() -> void:
	hide()
	_scale_mode_button.get_popup().id_pressed.connect(_on_scale_mode_id_pressed)


func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Background"),value)
	print(value)


func _on_son_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effet"), value)
	print(value)

func _on_close_button_pressed() -> void:
	hide()


func _on_full_screen_button_toggled(toggled_on: bool) -> void:
	if toggled_on : get_window().mode = Window.MODE_FULLSCREEN
	else : get_window().mode = Window.MODE_WINDOWED

func _on_h_slider_scale_value_changed(value: float) -> void:
	_scale_label.text = "Mise à l'échelle (%.2f)" % value
	get_viewport().scaling_3d_scale = value

func _on_scale_mode_id_pressed(id: int) -> void:
	match id :
		0 : 
			get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_BILINEAR
			_scale_mode_button.text = "Linéaire"
		1 : 
			get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_FSR
			_scale_mode_button.text = "FSR 1"
		2 : 
			get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_FSR2
			_scale_mode_button.text = "FSR 2"
		3 : 
			get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_METALFX_SPATIAL
			_scale_mode_button.text = "Métal FX"
		4 : 
			get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_METALFX_TEMPORAL
			_scale_mode_button.text = "Métal FX Temporel"
		5 : 
			get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_NEAREST
			_scale_mode_button.text = "Entière (Nearest)"
