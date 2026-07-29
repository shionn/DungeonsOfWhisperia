extends GridContainer

@onready var _scale_label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Scale
@onready var _scale_mode_button = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/GridContainer/ScaleModeButton
@onready var _vsync_mode_button = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/GridContainer/VSyncMode
@onready var _music_vol_label = $"PanelContainer/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Volume Music"
@onready var _effect_vol_label = $"PanelContainer/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Volume Son"
@onready var _music_slide = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/GridContainer/HSliderMusic
@onready var _effect_slide = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/GridContainer/HSliderSon
@onready var _full_screen = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/GridContainer/FullScreenButton
@onready var _scale_slide = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/GridContainer/HSliderScale
@onready var _ssao_button = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/GridContainer/ShadowSSAOButton

var _options : Dictionary = {}

func _ready() -> void:
	hide()
	_scale_mode_button.get_popup().id_pressed.connect(_on_scale_mode_id_pressed)
	_vsync_mode_button.get_popup().id_pressed.connect(_on_vsync_mode_id_pressed)
	_load()

func _load() -> void:
	var file_name = "user://options.save"
	if FileAccess.file_exists(file_name) :
		var file = FileAccess.open(file_name, FileAccess.READ)
		_options = JSON.parse_string(file.get_as_text())
		file.close()
	_apply()

func _save() -> void:
	var json_string = JSON.stringify(_options, "\t")
	var file = FileAccess.open("user://options.save", FileAccess.WRITE)
	file.store_line(json_string)
	file.close()

func _apply() -> void: 
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Background"), _options.get_or_add("audio-background-value", -24.0))
	_music_vol_label.text = "Volume Musique (%ddb)" % _options.get_or_add("audio-background-value", -24.0)
	_music_slide.value=_options.get_or_add("audio-background-value", -24.0)

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effet"), _options.get_or_add("audio-effect-value", 0.0))
	_effect_vol_label.text = "Volume Son (%ddb)" % _options.get_or_add("audio-effect-value", -0.0)
	_effect_slide.value=_options.get_or_add("audio-effect-value", 0.0)

	if _options.get_or_add("video-fullscreen", false) :
		get_window().mode = Window.MODE_FULLSCREEN
		_full_screen.button_pressed = true
	else :
		get_window().mode = Window.MODE_WINDOWED
		_full_screen.button_pressed = false

	_scale_label.text = "Mise à l'échelle (%.2f)" % _options.get_or_add("video-scale", 1.0)
	_scale_slide.value = _options.get_or_add("video-scale", 1.0)
	get_viewport().scaling_3d_scale = _options.get_or_add("video-scale")
	
	match _options.get_or_add("video-scale-mode", Viewport.SCALING_3D_MODE_BILINEAR) as Viewport.Scaling3DMode :
		Viewport.SCALING_3D_MODE_BILINEAR : _scale_mode_button.text = "Linéaire"
		Viewport.SCALING_3D_MODE_FSR : _scale_mode_button.text = "FSR 1"
		Viewport.SCALING_3D_MODE_FSR2 : _scale_mode_button.text = "FSR 2"
		Viewport.SCALING_3D_MODE_METALFX_SPATIAL : _scale_mode_button.text = "Métal FX"
		Viewport.SCALING_3D_MODE_METALFX_TEMPORAL : _scale_mode_button.text = "Métal FX Temporel"
		Viewport.SCALING_3D_MODE_NEAREST : _scale_mode_button.text = "Entière (Nearest)"
	get_viewport().scaling_3d_mode = _options.get_or_add("video-scale-mode", Viewport.SCALING_3D_MODE_BILINEAR)

	match _options.get_or_add("video-vsync", DisplayServer.VSYNC_ENABLED) as DisplayServer.VSyncMode : 
		DisplayServer.VSYNC_ENABLED:  _vsync_mode_button.text = "Activé"
		DisplayServer.VSYNC_ADAPTIVE: _vsync_mode_button.text = "Adaptatif"
		DisplayServer.VSYNC_DISABLED: _vsync_mode_button.text = "Désactivé"
	DisplayServer.window_set_vsync_mode(_options.get_or_add("video-vsync", DisplayServer.VSYNC_ENABLED))

	var env  = $"/root/World/Dungeon/Environment" as WorldEnvironment
	env.environment.ssao_enabled = _options.get_or_add("video-ssao", true)
	_ssao_button.button_pressed = _options.get_or_add("video-ssao", true)
	

func _on_music_value_changed(value: float) -> void:
	_options.set("audio-background-value", value)
	_apply()
	_save()

func _on_son_value_changed(value: float) -> void:
	_options.set("audio-effect-value", value)
	_apply()
	_save()

func _on_close_button_pressed() -> void:
	hide()

func _on_full_screen_button_toggled(toggled_on: bool) -> void:
	_options.set("video-fullscreen", toggled_on)
	_apply()
	_save()

func _on_h_slider_scale_value_changed(value: float) -> void:
	_options.set("video-scale", value)
	_apply()
	_save()

func _on_scale_mode_id_pressed(id: int) -> void:
	match id :
		0 : _options.set("video-scale-mode", Viewport.SCALING_3D_MODE_BILINEAR)
		1 : _options.set("video-scale-mode", Viewport.SCALING_3D_MODE_FSR)
		2 : _options.set("video-scale-mode", Viewport.SCALING_3D_MODE_FSR2)
		3 : _options.set("video-scale-mode", Viewport.SCALING_3D_MODE_METALFX_SPATIAL)
		4 : _options.set("video-scale-mode", Viewport.SCALING_3D_MODE_METALFX_TEMPORAL)
		5 : _options.set("video-scale-mode", Viewport.SCALING_3D_MODE_NEAREST)
	_apply()
	_save()

func _on_shadow_ssao_button_toggled(toggled_on: bool) -> void:
	_options.set("video-ssao", toggled_on)
	_apply()
	_save()

func _on_vsync_mode_id_pressed(id: int) -> void:
	match id : 
		0: _options.set("video-vsync", DisplayServer.VSYNC_ENABLED)
		1: _options.set("video-vsync", DisplayServer.VSYNC_ADAPTIVE)
		2: _options.set("video-vsync", DisplayServer.VSYNC_DISABLED)
	_apply()
	_save()
