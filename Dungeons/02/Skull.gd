extends Interactable

@onready var _blue = $blue
@onready var _red = $red
@onready var _orange = $orange
@onready var _gree = $green

@export var expected_obj : Items.ItemName = Items.ItemName.None

func on_item_drop(_item : Item)-> void:
	pass
