extends GameBaseControl

@onready var _label = $MarginContainer/Label as Label


func _physics_process(_delta: float) -> void:
	# TODO lvl pas explicie, ni l'xp, et depalcer le FPS
	_label.text = "♥ %d/%d   💰 %d   ★ %d (%d)  fps: %d" % [player.pv, player.get_max_pv(), bag.gold, player.xp, player.lvl, Engine.get_frames_per_second()]
	
