class_name LootGui
extends GridContainer

@onready var _container = $PanelContainer/MarginContainer/VBoxContainer/Container as Container
@onready var _items = $"/root/World/Items" as Items
@onready var _bag = $"/root/World/Player/Bag" as Bag
@onready var _bag_gui = $"../Bag" as BagGui

func _ready() -> void:
	self.visible = false

func loot(monster:Monster) -> void:
	for child in _container.get_children() : child.queue_free()
	var item : Item  = _items.from(monster.loot_obj)
	if item :
		var but = TextureButton.new();
		but.texture_normal =  item.icon
		but.tooltip_text = item.name
		but.pressed.connect(func(): self._loot_item(item, but, monster))
		_container.add_child(but)
	self.visible = true
	
func _loot_item(item:Item, button:TextureButton, monster:Monster) -> void:
	_bag.loot(item.item_name)
	monster.loot_obj = Items.ItemName.None
	button.queue_free()
	_bag_gui.refresh() # TODO passer par un signal sur le sac
	
