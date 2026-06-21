class_name LootGui
extends GridContainer

func _ready() -> void:
	self.visible = false

func loot(monster:Monster) -> void:
	var item : Item = monster.get_node("Item")
	var but = TextureButton.new();
	but.texture_normal =  item.icon
	$PanelContainer/MarginContainer/VBoxContainer/Container.add_child(but)
	self.visible = true
