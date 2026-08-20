extends PNJ

func interact() -> void:
	look_at_player()
	$"Présentation/Next/Gouffre des Ombres ?".enable = tags.have(Tags.AUBERGE_PLAYER_KNOW_SHADOW_CHASM) and not quest_book.dungeon_02.is_done()
	$"Présentation/Next/Valthorion ?".enable = quest_book.auberge_02_identifier_potion.is_done() and not quest_book.auberge_02_connaitre_valthorion.is_done()
	$"Présentation/Next/Chambres de l’Équilibre ?".enable = quest_book.auberge_03_identify_ring.is_done() and not quest_book.dungeon_03.is_done()
	gui.openDialog($"Présentation")


func _on_valthorion_next_close() -> void:
	quest_book.auberge_02_connaitre_valthorion.done()

func _on_chambre_equilibre_next_close() -> void:
	quest_book.auberge_03_trouver_mission.done()
