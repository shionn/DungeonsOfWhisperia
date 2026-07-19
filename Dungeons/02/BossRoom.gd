extends GameBase3D

@onready var _necromancer = $Necromancer



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body ==  player :
		gui.openDialog($NecromancerDialog)
	pass # Replace with function body.


func _on_necromancer_dialog_close() -> void:
	_necromancer.navitage_to($arch2.global_position)
	pass # Replace with function body.
