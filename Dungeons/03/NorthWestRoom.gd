extends GameBase3D



func _on_aswitch1_body_entered(body: Node3D) -> void:
	if body is PlayerG :
		$Switch1/AudioStreamPlayer3D.play()
		$Switch1.position.y = 0

func _on_switch1_body_exited(body: Node3D) -> void:
	if body is PlayerG :
		$Switch1/AudioStreamPlayer3D.play()
		$Switch1.position.y = 0.05
		
