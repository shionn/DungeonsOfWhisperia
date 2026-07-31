extends Label3D

func _ready() -> void:
	$AnimationPlayer.play("play")
	


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
