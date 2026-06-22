class_name LootGui
extends GridContainer

@onready var _container = $PanelContainer/MarginContainer/VBoxContainer/Container as Container

func _ready() -> void:
	self.visible = false

func loot(monster:Monster) -> void:
	for child in _container.get_children() : child.queue_free()
	var item : Item = monster.get_node("Item")
	var but = TextureButton.new();
	but.texture_normal =  item.icon
	_container.add_child(but)
	self.visible = true
	
