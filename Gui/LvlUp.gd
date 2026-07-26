extends GameBaseControl

func _ready() -> void:
	player.lvl_up.connect(_on_lvl_up)
	hide()

func _on_lvl_up() -> void:
	$AnimationPlayer.play("quest_done")
	$AudioStreamPlayer.play()
