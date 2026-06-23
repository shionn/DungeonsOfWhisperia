class_name BagGui
extends Control

@onready var _grid = $PanelContainer/MarginContainer/VBoxContainer/Container as Container
@onready var _container = $PanelContainer/MarginContainer/VBoxContainer/Container as Container
@onready var _bag = $"/root/World/Player/Bag" as Bag
@onready var _items = $"/root/World/Items" as Items

#var drag : Item = null

signal on_item_change()

func _ready() -> void:
	visible = false

func _process(_delta: float) -> void:
	#if drag != null :
	#	drag.global_position = get_viewport().get_mouse_position() + Vector2(5,5)
	pass

func refresh() -> void:
	for child in _container.get_children() : child.queue_free()
	for item_name in _bag.items :
		var item : Item  = _items.from(item_name)
		if item : 
			var but = TextureButton.new();
			but.texture_normal =  item.icon
			but.tooltip_text = item.name
			but.pressed.connect(func(): print(item))
			_container.add_child(but)




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
	on_item_change.emit()
