extends GameBaseControl

func _physics_process(_delta: float) -> void:
	visible = player.isDead()
	
