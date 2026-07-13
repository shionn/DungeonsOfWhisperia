class_name LootGui
extends GridContainer

@onready var _container = $PanelContainer/MarginContainer/VBoxContainer/Container as Container
@onready var _items = $"/root/World/Items" as Items
@onready var _bag = $"/root/World/Player/Bag" as Bag

var _goldRessource = load("res://Gui/Assets/kaykit/48/Coin_Stack_Small.png")

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
		if not item.unique or not _bag.have(item.item_name) :
			var button = TextureButton.new();
			button.texture_normal =  item.icon
			button.tooltip_text = item.tooltip
			button.pressed.connect(func(): self._loot_item(item, button, container))
			_container.add_child(button)
	self.visible = true
	if _container.get_child_count() > 0:
		$AudioOpen.play()
	
func _loot_item(item:Item, button:TextureButton, container:Object) -> void:
	_bag.loot(item.item_name)
	container.loot_obj = Items.ItemName.None
	button.queue_free()
	if container is Interactable and container.hide_on_loot : container.queue_free()
	if _container.get_child_count() == 1 : hide()

func _loot_gold(button:TextureButton, container:Object) -> void:
	_bag.gold = _bag.gold + container.loot_gold
	container.loot_gold = 0
	button.queue_free()
	if container is Interactable and container.hide_on_loot : container.queue_free()
	if _container.get_child_count() == 1 : hide()
	
