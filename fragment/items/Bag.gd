class_name Bag
extends Node

var items : Array[Items.ItemName] = []

func loot(item : Items.ItemName) -> void : 
	items.append(item)

func unloot(item : Items.ItemName) -> void : 
	var index = items.find(item)
	if index >=0 :
		items.remove_at(index)
