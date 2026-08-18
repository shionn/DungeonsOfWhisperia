extends Node3D

@export_category("coffre top")
@export var loot1 : Items.ItemName = Items.ItemName.None
@export var gold1 : int = 0

@export_category("coffre bottom")
@export var loot2 : Items.ItemName = Items.ItemName.None
@export var gold2 : int = 0

@onready var trunk1 = $Node3D
@onready var trunk2 = $Node3D2

func _ready() -> void:
	trunk1.loot_gold = gold1
	trunk1.loot_obj = loot1
	trunk2.loot_gold = gold2
	trunk2.loot_obj = loot2
	
