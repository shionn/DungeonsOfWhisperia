extends Node3D

@export var loot_gold_left = 0
@export var loot_gold_right = 0
@export var loot_item_left = Items.ItemName.None
@export var loot_item_right = Items.ItemName.None

@onready var _left = $bar_straight_C2
@onready var _right = $bar_straight_C3

func _ready() -> void:
	_left.loot_gold = loot_gold_left
	_left.loot_obj = loot_item_left
	_left._ready()
	_right.loot_gold = loot_gold_right
	_right.loot_obj = loot_item_right
	_right._ready()
