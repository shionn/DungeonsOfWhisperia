extends Control
class_name Bag

const BiereRousseDeEve = "BiereRousseDeEve"
const BoisDeQualite = "BoisDeQualite"
const BouteilleCapitain = "BouteilleCapitain"
const CarteHungConnut = "CarteHungConnut"
const Champignon = "Champignon"
const CrystalTeleportationOasis = "CrystalTeleportationOasis"
const FruitDefendu = "FruitDefendu"
const HacheKazrog = "HacheKazrog"
const Houblon = "Houblon"
const ListInvocationVent = "ListInvocationVent"
const LivreTransfo = "LivreTransfo"
const Melon = "Melon"
const Mojito = "Mojito"
const MojitoSansGlace = "MojitoSansGlace"
const Ossement = "Ossement"
const OssementBarbeDrue = "OssementBarbeDrue"
const PageHungConnutFrag1 = "PageHungConnutFrag1"
const PageHungConnutFrag2 = "PageHungConnutFrag2"
const PageHungConnutFrag3 = "PageHungConnutFrag3"
const ParcheminBarbeDrue = "ParcheminBarbeDrue"
const ParcheminBarbeDrueDecoder = "ParcheminBarbeDrueDecoder"
const ParcheminHungConnut = "ParcheminHungConnut"
const PasseBarque = "PasseBarque"
const PasseBarqueTanpon = "PasseBarqueTanpon"
const Pioche = "Pioche"
const Plume = "Plume"
const PotionDegrisement = "PotionDegrisement"
const TresorBarbeDrue = "TresorBarbeDrue"
const TresorBarbeDrueNet = "TresorBarbeDrueNet"
const TresorBarbeDrueMaudit = "TresorBarbeDrueMaudit"
const TresorHungConnut = "TresorHungConnut"
const TresorHungConnutNet = "TresorHungConnutNet"
const SelDeMontagne = "SelDeMontagne"

@onready var _grid = $PanelContainer/MarginContainer/VBoxContainer/Container as Container
@onready var _items = $"../Items" as Control
#@onready var _gui = $".." as Gui

#var drag : Item = null

signal on_item_change()

func _ready() -> void:
	visible = false

func _process(_delta: float) -> void:
	#if drag != null :
	#	drag.global_position = get_viewport().get_mouse_position() + Vector2(5,5)
	pass

func loot(item_name : String) -> void :
	var item = _items.get_node(item_name)
	if item and _items.is_ancestor_of(item) :
		_items.remove_child(item)
		_grid.add_child(item)
		#_gui.append_to_console("Vous obtenez <"+item.tooltip_text+">")
		on_item_change.emit()
	else :
		print("loot error " + item_name)

func unloot(item_name : String) -> void :
	var item = _grid.get_node(item_name)
	if item :
		_grid.remove_child(item)
		item.global_position = Vector2(-100,-100)
		_items.add_child(item)
		on_item_change.emit()

func contain(item_name : String) -> bool:
	return _grid.get_node(item_name) != null
	
func empty() :
	return _grid.get_child_count() == 0

func _on_close_button_pressed() -> void:
	hide()

func save_game() -> void :
	var file = FileAccess.open("user://bag.save", FileAccess.WRITE)
	var item_names = []
	for item in _grid.get_children() : item_names.append(item.name)
	var json_string = JSON.stringify(item_names)
	file.store_line(json_string)

func load_game() -> void : 
	if FileAccess.file_exists("user://bag.save") :
		for item in _grid.get_children() : unloot(item.name)
		var file = FileAccess.open("user://bag.save", FileAccess.READ)
		for item_name in JSON.parse_string(file.get_line()) :
			var item = _items.get_node(item_name)
			_items.remove_child(item)
			_grid.add_child(item)
	on_item_change.emit()
