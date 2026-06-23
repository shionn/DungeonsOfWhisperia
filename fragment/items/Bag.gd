class_name Bag
extends Node

var items : Array[Items.ItemName] = []
var gold: int = 0:
	set(value) :
		gold = value
		on_item_change.emit()

signal on_item_change()
	

func loot(item : Items.ItemName) -> void : 
	items.append(item)
	on_item_change.emit()

func unloot(item : Items.ItemName) -> void : 
	var index = items.find(item)
	if index >=0 :
		items.remove_at(index)
	on_item_change.emit()
