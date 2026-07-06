extends GameBaseControl

func _init() -> void:
	hide()

func _on_dungeon_01_pressed() -> void:
	gui._close()
	gui.openTransition(func():_goTo("res://Dungeons/01/Dungeon01.tscn"))


func _goTo(path : String) -> void : 
	var dungeon = $/root/World/Dungeon as Node3D
	dungeon.name = "old"
	dungeon.queue_free()
	dungeon = load(path).instantiate()
	dungeon.name = "Dungeon"
	world.add_child(dungeon)
	player.reset_orientation()
	
