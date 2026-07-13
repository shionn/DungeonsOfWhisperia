extends PNJ

func interact() -> void:
	gui.openDialog($Bienvenue)

func _on_acheter_next_activate() -> void:
	_animation.play("RigMedium/Cheering")
	_animation.queue("RigMedium/Idle_A")
	print("ca joue pas")

func _on_potion_de_soin_mineur_activate() -> void:
	gui.openDialog($ManquePo)

func _on_potion_de_soin_moyenne_activate() -> void:
	gui.openDialog($ManquePo)

func _on_potion_de_soin_majeur_activate() -> void:
	gui.openDialog($ManquePo)
