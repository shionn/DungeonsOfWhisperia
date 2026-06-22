class_name Item
extends Node

@export var icon : Resource

signal action()

func execute() -> void:
	action.emit()

func _give_back_4_pv() -> void:
	$"../../Player".pv = min($"../../Player".pv+4, $"../../Player".maxpv)
	
