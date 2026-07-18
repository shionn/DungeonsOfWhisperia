extends Interactable

@onready var _blue = $blue
@onready var _red = $red
@onready var _orange = $orange
@onready var _green = $green

@export var expected_obj : Items.ItemName = Items.ItemName.None

var state = false : 
	set(value) :
		state = value
		state_change.emit()

signal state_change()

func on_interact() -> void:
	if loot_obj == Items.ItemName.None:
		gui.openDialog(_description)
	else :
		open_loot()

func on_item_drop(_item : Item)-> void:
	if _item.gemme :
		if loot_obj == Items.ItemName.None:
			loot_obj = _item.item_name
			bag.unloot(_item.item_name)
			$Lock02.play()
			state = loot_obj == expected_obj
		else :
			gui.openDialog($already_sloted)
	else :
		super.on_item_drop(_item)

func on_loot_obj_change() -> void:
	_blue.hide()
	_red.hide()
	_orange.hide()
	_green.hide()
	match loot_obj : 
		Items.ItemName.GemmeRouge : _red.show()
		Items.ItemName.GemmeVert : _green.show()
		Items.ItemName.GemmeJaune : _orange.show()
		Items.ItemName.GemmeBleu : _blue.show()
	
