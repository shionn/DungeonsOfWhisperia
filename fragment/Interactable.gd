extends Node3D
class_name Interactable

enum Action { ACTIVATE, LOOK }

@onready var _gui := $/root/World/Gui as Gui
@onready var _player := $/root/World/Player as PlayerG
@onready var _bag := $/root/World/Player/Bag as Bag
@onready var _area := $Area3D as Area3D
@onready var _bagGui := $/root/World/Gui/Bag as BagGui
@onready var _audio := $AudioStreamPlayer3D

@export var action : Action = Action.ACTIVATE
@export var interactDistance : float = 3

@export var loot_obj : Items.ItemName = Items.ItemName.None
@export var loot_gold: int = 0
@export var hide_on_loot: bool = false

signal activate() 
signal item_drop(_item : Item)

var _lootable = false

func _ready() -> void:
	_area.connect("mouse_entered", _on_mouse_entered)
	_area.connect("mouse_exited", _on_mouse_exited)
	_area.connect("input_event", _on_input_event)
	_lootable = loot_gold > 0 or loot_obj

func on_interact() -> void: 
	if _audio : _audio.play()
	if $description :
		_gui.openDialog($description)
	elif _lootable :
		_gui.openLoot(self)
	else : 
		activate.emit()

func open_description() -> void:
	if $description :
		_gui.openDialog($description)

func open_loot() -> void:
	_gui.openLoot(self)

func isInRange(target: Node3D) -> bool:
	return global_position.distance_to(target.global_position) <= interactDistance

func _on_mouse_entered() -> void:
	#print("_on_mouse_entered")
	_bagGui.on_enter(self)

func _on_mouse_exited() -> void:
	#print("_on_mouse_exited")
	_bagGui.on_exit(self)

func on_item_drop(_item : Item)-> void:
	item_drop.emit(_item)
	# TODO remettre ca en place.
	# _gui.consoleLog("Aucun effet.")
	

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	#if event is InputEventMouseButton and Input.is_action_just_pressed("interact"): 
#		if player :
#			if player.global_position.distance_to(self.global_position) < interactable_distance :
#				#player.play_anim_interact()
#				on_interact()
#			else :
#				player.play_anim_no()
#				gui.append_to_console("Trop loin")
#		else :
	#		on_interact()
	pass
