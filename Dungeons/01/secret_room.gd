extends Node3D

func open() -> void:
	if $wall : 
		$/root/World/Gui/Transition.doIt(self._openRoom)
		
func _openRoom() -> void :
	$wall.queue_free()
	$wall_open_scaffold.show()
	$AudioStreamPlayer3D.play()
	
