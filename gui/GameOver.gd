extends Label

@onready var _player = $/root/World/Player as PlayerG

func _physics_process(delta: float) -> void:
	visible = _player.pv <= 0
