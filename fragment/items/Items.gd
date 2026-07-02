class_name Items
extends Node

enum ItemName {
	None,
	Potion,
	ClefBouclierEpee,
	BoissonRaffinee,
	ClefCoffre
}

func from(item_name : ItemName) -> Item :
	for item in get_children() :
		if item is Item :
			var i = item as Item
			if i.item_name == item_name :
				return i
	return null
