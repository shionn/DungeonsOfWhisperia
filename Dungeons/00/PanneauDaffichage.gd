extends Interactable


func on_interact() -> void:
	if tags.have(Tags.AUBERGE_PLAYER_RESTORED) : gui.openDialog($"Mission 1")
	else :  gui.openDialog($Description)


func _on_mission_1_close() -> void:
	tags.add(Tags.DUNGEON_01_ENABLE)
