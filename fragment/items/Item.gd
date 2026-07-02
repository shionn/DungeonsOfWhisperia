class_name Item
extends GameBase

@export var item_name : Items.ItemName = Items.ItemName.None
@export var icon : Resource
@export_multiline() var description : String
@export var tooltip : String
@export var conssommable : bool = false

signal _action()

func execute() -> void:
	_action.emit()
	
func open_description() -> void:
	if $description : gui.openDialog($description)
	else : 
		var desc = Dialog.new()
		desc.name = "description"
		desc.text = description
		add_child(desc)
		gui.openDialog(desc)

func _give_back_2_pv() -> void:
	$"../../Player".pv = min($"../../Player".pv+2, $"../../Player".maxpv)
	
func _give_back_1d3_pv() -> void:
	var pv = Dices.d3()
	$"../../Player".pv = min($"../../Player".pv+pv, $"../../Player".maxpv)
