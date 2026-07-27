class_name Item
extends GameBase

@export var item_name : Items.ItemName = Items.ItemName.None
@export var icon : Resource
@export var tooltip : String :
	get() : return display_name if tooltip.is_empty() else tooltip
@export var display_name : String : 
	get() : return name as String if display_name.is_empty() else display_name
@export_multiline() var description : String
@export_category("Utilisation")
@export var conssommable : bool = false
@export_category("Loot Condition")
@export var global : bool = true
@export var unique : bool = false
@export_category("Item type")
@export var gemme : bool = false

signal _action()

func execute() -> void:
	_action.emit()
	
func open_description() -> void:
	if $description : gui.openDialog($description)
	else : 
		var desc = Dialog.new()
		desc.name = "description"
		desc.text = description
		if global : desc.text = description
		else : desc.text = description +"\n\n[i]Cet objet est lié au donjon, on ne pas le garder en sortant.[/i]"
		add_child(desc)
		gui.openDialog(desc)

func lootable() -> bool :
	return not unique or not bag.have(item_name) 

func _give_back_2_pv() -> void:
	player.pv = min(player.pv+2, player.get_max_pv())
	
func _give_back_1d3_pv() -> void:
	var pv = Dices.d3()
	player.pv = min(player.pv+pv, player.get_max_pv())

func _give_back_4_6_pv() -> void:
	var pv = Dices.d3()+3
	player.pv = min(player.pv+pv, player.get_max_pv())

func _give_back_7_9_pv() -> void:
	var pv = Dices.d3()+6
	player.pv = min(player.pv+pv, player.get_max_pv())
