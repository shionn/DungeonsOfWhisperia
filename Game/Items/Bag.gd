class_name Bag
extends Node

@onready var _gui = $/root/World/Gui as Gui
@onready var _items = $/root/World/Items as Items

var items : Array[Items.ItemName] = []
var gold: int = 0:
	set(value) :
		_gui.consoleLog("Vous obtenez %d 💰." % [value-gold])
		gold = value
		item_change.emit()

signal item_change()
	

func loot(item : Items.ItemName) -> void : 
	items.append(item)
	item_change.emit()
	_gui.consoleLog("Vous obtenez %s." % _items.from(item).name)

func unloot(item : Items.ItemName) -> void : 
	var index = _items.find(item)
	if index >=0 :
		_gui.consoleLog("Vous utilisez %s." % _items.from(item).name)
		items.remove_at(index)
	item_change.emit()
