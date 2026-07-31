extends GameBase3D

func _ready() -> void:
	$StateLabel/AnimationPlayer.play("play")
	
func _physics_process(_delta: float) -> void:
	look_at(get_viewport().get_camera_3d().global_position, Vector3.UP, true)
	rotation.x=0

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()

func set_text(text:String) -> void:
	$StateLabel.text = text
