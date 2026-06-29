extends Control

@onready var _label = $MarginContainer/Label as Label
@onready var _player = $/root/World/Player as PlayerG
@onready var _bag = $/root/World/Player/Bag as Bag


func _physics_process(_delta: float) -> void:
	_label.text = "♥ %d/%d   💰 %d" % [_player.pv, _player.maxpv, _bag.gold]
