extends Control

@onready var _label = $MarginContainer/Label as Label
@onready var _player = $/root/World/Player as PlayerG


func _physics_process(_delta: float) -> void:
	_label.text = "PV "+str(_player.pv) +"/"+str(_player.maxpv)
