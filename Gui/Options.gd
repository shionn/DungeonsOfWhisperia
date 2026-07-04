extends GridContainer

func _init() -> void:
	hide()

func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Background"),value)
	print(value)


func _on_son_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effet"), value)
	print(value)

func _on_close_button_pressed() -> void:
	hide()
