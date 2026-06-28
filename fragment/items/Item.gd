class_name Item
extends Node

@export var item_name : Items.ItemName = Items.ItemName.None
@export var icon : Resource
@export_multiline() var description : String
@export var conssommable : bool = false

signal _action()

func execute() -> void:
	_action.emit()

func _give_back_4_pv() -> void:
	$"../../Player".pv = min($"../../Player".pv+4, $"../../Player".maxpv)
	
func _give_back_1d3_pv() -> void:
	var pv = Dices.d3()
	$"../../Player".pv = min($"../../Player".pv+pv, $"../../Player".maxpv)
	
