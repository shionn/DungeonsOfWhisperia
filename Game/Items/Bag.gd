class_name Bag
extends GameBase

@onready var _all_items = $/root/World/Items as Items

var _items : Array[Items.ItemName] = []
var gold: int = 0:
	set(value) :
		if value > gold : gui.consoleLog("Vous obtenez %d 💰." % [value-gold])
		elif value < gold : gui.consoleLog("Vous perdez %d 💰." % [gold-value])
		gold = value
		item_change.emit()

signal item_change()

func loot(item : Items.ItemName) -> void : 
	_items.append(item)
	item_change.emit()
	var _i =  _all_items.from(item)
	if _i.tag : tags.add(_i.tag)
	gui.consoleLog("Vous obtenez %s." % _i.name)

func unloot(item : Items.ItemName) -> void : 
	var index = _items.find(item)
	if index >=0 :
		gui.consoleLog("Vous utilisez %s." % _all_items.from(item).name)
		_items.remove_at(index)
	item_change.emit()

func have(item : Items.ItemName) -> bool:
	return _items.find(item) >= 0
	
	
func to_save() -> Array[Items.ItemName] : 
	var saveable_items : Array[Items.ItemName] = []
	for item_name in _items :
		if _all_items.from(item_name).global :
			saveable_items.append(item_name)
	return saveable_items

func items() -> Array[Items.ItemName] :
	return _items
