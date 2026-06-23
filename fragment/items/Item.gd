class_name Item
extends Node

@export var item_name : Items.ItemName = Items.ItemName.None
@export var icon : Resource



signal _action()

func execute() -> void:
	_action.emit()

func _give_back_4_pv() -> void:
	$"../../Player".pv = min($"../../Player".pv+4, $"../../Player".maxpv)
	
