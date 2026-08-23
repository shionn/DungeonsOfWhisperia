extends GameBase3D

var target : Monster

func _ready() -> void:
	var spell = player.get_node("Entrave") as Spell
	spell.enable_change.connect(_on_enable_change)
	
func _on_enable_change(enable) -> void : 
	if not enable : queue_free()
