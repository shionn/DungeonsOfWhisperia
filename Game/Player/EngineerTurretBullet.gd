extends Node3D

signal hit()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if _anim_name == "Fire" :
		$Location/VFXHit_01.show()
		$Location/VFXHit_01/AnimationPlayer.play("main")
		hit.emit()
		$Boom.play()
	if _anim_name == "main" :
		queue_free()
