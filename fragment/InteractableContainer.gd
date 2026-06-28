class_name InteractableContainer
extends "res://fragment/Interactable.gd"

@export var loot_obj : Items.ItemName = Items.ItemName.None
@export var loot_gold: int = 0
@export var hide_on_loot: bool = false

func on_interact() -> void:
	_gui.openLoot(self)
