extends GameBaseControl

func _physics_process(_delta: float) -> void:
	visible = player.isDead()
	


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_title_pressed() -> void:
	var start = preload("res://GameStart.tscn").instantiate()
	get_tree().change_scene_to_node(start)
