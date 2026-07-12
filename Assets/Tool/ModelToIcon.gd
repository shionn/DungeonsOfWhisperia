extends Node3D


	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey : 
		var e = event as InputEventKey 
		if e.keycode == KEY_R :
			var window = get_window()
			window.mode = Window.MODE_WINDOWED
			window.size = Vector2i(512,512)
			print(window.size)
		if e.keycode == KEY_T :
			var img = get_viewport().get_texture().get_image()
			var node = get_children().get(get_children().size()-1)
			# Gui/Assets/kaykit/
			img.save_png("%s.png"%[node.name])
			print("done")
			
