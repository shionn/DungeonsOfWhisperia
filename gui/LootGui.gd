class_name LootGui
extends GridContainer

@onready var _container = $PanelContainer/MarginContainer/VBoxContainer/Container as Container
@onready var _items = $"/root/World/Items" as Items
@onready var _bag = $"/root/World/Player/Bag" as Bag

var _goldRessource = load("res://assets/resources-pack-1/Coin-48.png")

func _ready() -> void:
	self.visible = false

func loot(monster:Monster) -> void:
	for child in _container.get_children() : child.queue_free()
	if monster.loot_gold > 0:
		var button = TextureButton.new();
		button.texture_normal = _goldRessource
		button.tooltip_text = "OR: "+str(monster.loot_gold)+"\n Ceci"
		button.pressed.connect(func(): self._loot_gold(button, monster))
		_container.add_child(button)

	var item : Item  = _items.from(monster.loot_obj)
	if item :
		var button = TextureButton.new();
		button.texture_normal =  item.icon
		button.tooltip_text = item.name
		button.pressed.connect(func(): self._loot_item(item, button, monster))
		_container.add_child(button)
	self.visible = true
	
func _loot_item(item:Item, button:TextureButton, monster:Monster) -> void:
	_bag.loot(item.item_name)
	monster.loot_obj = Items.ItemName.None
	button.queue_free()

func _loot_gold(button:TextureButton, monster:Monster) -> void:
	_bag.gold = _bag.gold + monster.loot_gold
	monster.loot_gold = 0
	button.queue_free()
	
