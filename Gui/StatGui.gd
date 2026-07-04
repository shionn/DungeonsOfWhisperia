extends GameBaseControl

@onready var _label = $MarginContainer/Label as Label


func _physics_process(_delta: float) -> void:
	_label.text = "♥ %d/%d   💰 %d" % [player.pv, player.get_max_pv(), bag.gold]
