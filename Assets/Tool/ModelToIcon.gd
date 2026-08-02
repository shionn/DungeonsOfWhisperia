extends Node3D

func _ready() -> void:
	#$Skeleton_Minion/Rig_Medium/Skeleton3D/Skeleton_Minion_ArmLeft.hide()
	#$Skeleton_Minion/Rig_Medium/Skeleton3D/Skeleton_Minion_ArmRight.hide()
	#$Skeleton_Minion/Rig_Medium/Skeleton3D/Skeleton_Minion_Body.hide()
	#$Skeleton_Minion/Rig_Medium/Skeleton3D/Skeleton_Minion_Cloak.hide()
	#$Skeleton_Minion/Rig_Medium/Skeleton3D/Skeleton_Minion_Jaw.hide()
	#$Skeleton_Minion/Rig_Medium/Skeleton3D/Skeleton_Minion_LegLeft.hide()
	#$Skeleton_Minion/Rig_Medium/Skeleton3D/Skeleton_Minion_LegRight.hide()
	$Rogue_Hooded/Rig_Medium/Skeleton3D/RogueHooded_Body.hide()
	$Rogue_Hooded/Rig_Medium/Skeleton3D/RogueHooded_Cape.hide()
	$Rogue_Hooded/Rig_Medium/Skeleton3D/RogueHooded_ArmRight.hide()
	$Rogue_Hooded/Rig_Medium/Skeleton3D/RogueHooded_ArmLeft.hide()
	pass
	
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
			img.save_png("Gui/Assets/kaykit/%s.png"%[node.name])
			print("done")
			
