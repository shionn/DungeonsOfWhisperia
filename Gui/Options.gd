class_name Options
extends Node

signal applied()

var _options : Dictionary = {}

func _ready() -> void:
	load_to_file()

func load_to_file() -> void:
	var file_name = "user://options.save"
	if FileAccess.file_exists(file_name) :
		var file = FileAccess.open(file_name, FileAccess.READ)
		_options = JSON.parse_string(file.get_as_text())
		file.close()
	apply()

func save_to_file() -> void:
	var json_string = JSON.stringify(_options, "\t")
	var file = FileAccess.open("user://options.save", FileAccess.WRITE)
	file.store_line(json_string)
	file.close()

func apply_and_save() -> void:
	apply()
	save_to_file()

func apply() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Background"), get_audio_backbround_vol() )
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effet"),      get_audio_effect_vol())

	if is_fullscreen() : get_window().mode = Window.MODE_FULLSCREEN
	else :               get_window().mode = Window.MODE_WINDOWED

	get_viewport().scaling_3d_scale = get_video_scale()
	get_viewport().scaling_3d_mode  = get_video_scale_mode()

	DisplayServer.window_set_vsync_mode(get_vsync_mode())

	var env  = $"/root/World/Dungeon/Environment" as WorldEnvironment
	env.environment.ssao_enabled = is_ssao_enable()
	
	get_viewport().get_camera_3d().fov = get_video_fov()
	
	applied.emit()

func get_audio_backbround_vol() -> float : return _options.get_or_add("audio-background-value", -24.0)
func get_audio_effect_vol()     -> float : return _options.get_or_add("audio-effect-value", -24.0)
func is_fullscreen()            -> bool  : return _options.get_or_add("video-fullscreen", false)
func get_video_scale()          -> float : return _options.get_or_add("video-scale", 1.0)
func get_video_scale_mode()     -> Viewport.Scaling3DMode : return _options.get_or_add("video-scale-mode", Viewport.SCALING_3D_MODE_BILINEAR)
func get_vsync_mode()           -> DisplayServer.VSyncMode : return _options.get_or_add("video-vsync", DisplayServer.VSYNC_ENABLED)
func is_ssao_enable()           -> bool  : return _options.get_or_add("video-ssao", true)
func get_video_fov()            -> float : return _options.get_or_add("video-fov", 75.0)

func set_audio_backbround_vol(value: float) -> void : _options.set("audio-background-value", value)
func set_audio_effect_vol(value: float) -> void : _options.set("audio-effect-value", value)
func set_fullsceen(value: bool) -> void : _options.set("video-fullscreen", value)
func set_video_scale(value: float) -> void : _options.set("video-scale", value)
func set_video_scale_mode(value: Viewport.Scaling3DMode) -> void : _options.set("video-scale-mode", value)
func set_vsync_mode(value: DisplayServer.VSyncMode) -> void : _options.set("video-vsync", value)
func set_ssao(value: bool) -> void : _options.set("video-ssao", value)
func set_video_fov(value: float) -> void : _options.set("video-fov", value)
