class_name Bag
extends Node

@onready var _gui = $/root/World/Gui as Gui
@onready var _items = $/root/World/Items as Items

var items : Array[Items.ItemName] = []
var gold: int = 0:
	set(value) :
		gold = value
		on_item_change.emit()
		_gui.consoleLog("Vous obtenez %d pieces d'or." % value)

signal on_item_change()
	

func loot(item : Items.ItemName) -> void : 
	items.append(item)
	on_item_change.emit()
	_gui.consoleLog("Vous obtenez %s." % _items.from(item).name)

func unloot(item : Items.ItemName) -> void : 
	var index = items.find(item)
	if index >=0 :
		items.remove_at(index)
	on_item_change.emit()
