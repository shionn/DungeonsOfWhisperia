extends GameBase3D
class_name Interactable

enum Action { ACTIVATE, LOOK }

@onready var _area := $Area3D as Area3D
@onready var _bagGui := $/root/World/Gui/Bag as BagGui

@export var action : Action = Action.ACTIVATE
@export var interactDistance : float = 3

@export var loot_obj : Items.ItemName = Items.ItemName.None :
	set(value) :
		loot_obj = value
		if value != Items.ItemName.None : _lootable = true
		loot_obj_change.emit()
		
@export var loot_gold: int = 0 :
	set(value) :
		loot_gold = value
		if value > 0 : _lootable = true
		loot_obj_change.emit()
@export var hide_on_loot: bool = false

signal activate() 
signal item_drop(_item : Item)
signal loot_obj_change()

var _lootable = false
var _audio : AudioStreamPlayer3D
var _description : Dialog

func _ready() -> void:
	_area.connect("mouse_entered", _on_mouse_entered)
	_area.connect("mouse_exited", _on_mouse_exited)
	_audio = get_node_or_null("AudioStreamPlayer3D")
	_description = get_node_or_null("description")
	_lootable = loot_gold > 0 or loot_obj

func on_interact() -> void: 
	if _audio : _audio.play()
	if _description :
		gui.openDialog(_description)
	elif _lootable :
		gui.openLoot(self)
	else : 
		activate.emit()

func open_description() -> void:
	if _description :
		gui.openDialog(_description)

func open_loot() -> void:
	gui.openLoot(self)

func is_in_range() -> bool:
	return player.distance_to(self) <= interactDistance

func _on_mouse_entered() -> void:
	_bagGui.on_enter(self)

func _on_mouse_exited() -> void:
	_bagGui.on_exit(self)

func on_item_drop(_item : Item)-> void:
	item_drop.emit(_item)
	if item_drop.get_connections().is_empty() :
		gui.consoleLog("Aucun effet.")
