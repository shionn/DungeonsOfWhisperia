class_name BagGui
extends GameBaseControl

@onready var _grid = $PanelContainer/MarginContainer/VBoxContainer/Container as Container
@onready var _container = $PanelContainer/MarginContainer/VBoxContainer/Container as Container
@onready var _items = $"/root/World/Items" as Items

var _goldRessource = load("res://Gui/Assets/kaykit/48/Coin_Stack_Small.png")
var _dragButton : TextureButton
var _interactable : Interactable

#var drag : Item = null
func _ready() -> void:
	visible = false
	bag.item_loot.connect(self._refresh)
	bag.item_drop.connect(self._refresh)
	bag.gold_loot.connect(self._refresh)

func _process(_delta: float) -> void:
	if _dragButton:
		_dragButton.global_position = get_viewport().get_mouse_position() + Vector2(5,5)

func _refresh() -> void:
	for child in _container.get_children() : child.queue_free()
	if bag.gold > 0:
		var button = TextureButton.new();
		button.texture_normal = _goldRessource
		button.tooltip_text = "OR: "+str(bag.gold)
		button.button_mask = MOUSE_BUTTON_MASK_LEFT | MOUSE_BUTTON_MASK_RIGHT
		_container.add_child(button)

	for item_name in bag.items() :
		var item : Item  = _items.from(item_name)
		if item : 
			var button = TextureButton.new();
			button.texture_normal =  item.icon
			button.tooltip_text = item.tooltip
			button.button_mask = MOUSE_BUTTON_MASK_RIGHT | MOUSE_BUTTON_MASK_LEFT
			button.pressed.connect(func(): self._activate(item))
			button.button_down.connect(func(): self._start_drag(button, item))
			button.button_up.connect(func(): self._end_drag(button, item))
			_container.add_child(button)

func _start_drag(button : TextureButton, _item : Item) -> void :
	if Input.is_action_just_pressed("interact"):
		_dragButton = button
		_dragButton.set_default_cursor_shape(Control.CURSOR_DRAG)
		#set_default_cursor_shape()

func _end_drag(_button : TextureButton, item : Item) -> void :
	if Input.is_action_just_released("interact") and _dragButton:
		if _interactable :
			_interactable.on_item_drop(item)
		_dragButton.set_default_cursor_shape(Control.CURSOR_ARROW)
		_dragButton = null
		_refresh()

func on_enter(interactable : Node3D) -> void :
	if _dragButton :
		self._interactable = interactable
		_dragButton.set_default_cursor_shape(Control.CURSOR_CAN_DROP)

func on_exit(interactable : Node3D) -> void :
	if self._interactable == interactable and _dragButton:
		_dragButton.set_default_cursor_shape(Control.CURSOR_DRAG)
		self._interactable = null

func _activate(item : Item) -> void :
	if player.isDead() : return
	if Input.is_action_just_released("interact"):
		item.open_description()
	else :
		item._action.emit()
		if item.conssommable :
			bag.unloot(item.item_name)

func _on_close_button_pressed() -> void:
	hide()

func save_game() -> void :
	var file = FileAccess.open("user://bag.save", FileAccess.WRITE)
	var item_names = []
	for item in _grid.get_children() : item_names.append(item.name)
	var json_string = JSON.stringify(item_names)
	file.store_line(json_string)

func load_game() -> void : 
	#if FileAccess.file_exists("user://bag.save") :
		#for item in _grid.get_children() : unloot(item.name)
		#var file = FileAccess.open("user://bag.save", FileAccess.READ)
		#for item_name in JSON.parse_string(file.get_line()) :
			#var item = _items.get_node(item_name)
			#_items.remove_child(item)
			#_grid.add_child(item)
	#on_item_change.emit()
	pass

func _on_visibility_changed() -> void:
	if visible and _container : 
		_dragButton = null
		_refresh()
