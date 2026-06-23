class_name Items
extends Node

enum ItemName {
	None,
	Potion
}

func from(name : ItemName) -> Item :
	match name :
		ItemName.Potion:
			return $Potion
		_: return null
