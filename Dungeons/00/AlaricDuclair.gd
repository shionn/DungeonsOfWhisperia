extends PNJ

func interact() -> void:
	look_at_player()
	$"Présentation/Next/Gouffre des Ombres ?".enable = tags.have(Tags.AUBERGE_PLAYER_KNOW_SHADOW_CHASM)
	$"Présentation/Next/Valthorion ?".enable = quest_book.auberge_02_identifier_potion.is_done()
	gui.openDialog($"Présentation")


func _on_valthorion_next_close() -> void:
	quest_book.auberge_02_connaitre_valthorion.done()
