class_name LootGui
extends GridContainer

@onready var _container = $PanelContainer/MarginContainer/VBoxContainer/Container as Container
@onready var _items = $"/root/World/Items" as Items
@onready var _bag = $"/root/World/Player/Bag" as Bag

var _goldRessource = load("res://assets/resources-pack-1/Coin-48.png")

func _ready() -> void:
	self.visible = false

func loot(container:Object) -> void:
	for child in _container.get_children() : child.queue_free()
	if container.loot_gold > 0:
		var button = TextureButton.new();
		button.texture_normal = _goldRessource
		button.tooltip_text = "OR: "+str(container.loot_gold)
		button.pressed.connect(func(): self._loot_gold(button, container))
		_container.add_child(button)

	var item : Item  = _items.from(container.loot_obj)
	if item :
		var button = TextureButton.new();
		button.texture_normal =  item.icon
		button.tooltip_text = item.name+"\n"+item.description
		button.pressed.connect(func(): self._loot_item(item, button, container))
		_container.add_child(button)
	self.visible = true
	
func _loot_item(item:Item, button:TextureButton, container:Object) -> void:
	_bag.loot(item.item_name)
	container.loot_obj = Items.ItemName.None
	if container is InteractableContainer and container.hide_on_loot :
		container.queue_free()
	button.queue_free()

func _loot_gold(button:TextureButton, container:Object) -> void:
	_bag.gold = _bag.gold + container.loot_gold
	container.loot_gold = 0
	button.queue_free()
	
