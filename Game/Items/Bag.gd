class_name Bag
extends GameBase

@onready var _all_items = $/root/World/Items as Items

var _items : Array[Items.ItemName] = []
var gold: int = 0:
	set(value) :
		if value > gold : gui.consoleLog("Vous obtenez %d 💰." % [value-gold])
		elif value < gold : gui.consoleLog("Vous perdez %d 💰." % [gold-value])
		gold = value
		gold_loot.emit()

signal gold_loot()
signal item_loot(item : Item)
signal item_drop(item : Item)

func loot(item : Items.ItemName) -> void : 
	_items.append(item)
	var _i =  _all_items.from(item)
	gui.consoleLog("Vous obtenez %s." % _i.display_name)
	item_loot.emit(_i)

func unloot(item : Items.ItemName) -> void : 
	var index = _items.find(item)
	if index >=0 :
		gui.consoleLog("Vous utilisez %s." % _all_items.from(item).display_name)
		_items.remove_at(index)
	var _i =  _all_items.from(item)
	item_drop.emit(_i)

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
