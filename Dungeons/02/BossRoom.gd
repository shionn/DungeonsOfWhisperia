extends GameBase3D

@onready var _necromancer = $Valthorion

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body ==  player and _necromancer:
		gui.openDialog($NecromancerDialog)
	

func _on_necromancer_dialog_close() -> void:
	_necromancer._navigation_agent.navigation_finished.connect(_navigation_finish)
	_necromancer.navitage_to($arch2.global_position)
	
func _navigation_finish() -> void :
	_necromancer.queue_free()
	$"Skeleton Golem".state = Monster.State.IDLE
