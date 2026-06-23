class_name LootGui
extends GridContainer

@onready var _container = $PanelContainer/MarginContainer/VBoxContainer/Container as Container
@onready var _items = $"/root/World/Items" as Items

func _ready() -> void:
	self.visible = false

func loot(monster:Monster) -> void:
	for child in _container.get_children() : child.queue_free()
	var item : Item  = _items.from(monster.loot_obj)
	if item :
		var but = TextureButton.new();
		but.texture_normal =  item.icon
		but.tooltip_text = item.name
		but.pressed.connect(func(): print(item))
		_container.add_child(but)
	self.visible = true
	
