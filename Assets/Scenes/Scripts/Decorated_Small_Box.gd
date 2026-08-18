extends Node3D

@onready var _trunk = $trunk_small_A2
@onready var _coins = $Coins

@export var loot_gold : int = 0
@export var loot_item : Items.ItemName = Items.ItemName.None

func _ready() -> void:
	if loot_gold == 0 : _coins.queue_free()
	_trunk.loot_gold = loot_gold
	_trunk.loot_obj = loot_item
	_trunk._ready()

func _on_trunk_small_a_2_loot_obj_change() -> void:
	if _trunk.loot_gold == 0 and _coins : _coins.queue_free()
