class_name Items
extends GameBase

enum ItemName {
	None,
	PotionVieMineur,
	ClefBouclierEpee,
	BoissonRaffinee,
	ClefCoffre,
	SkullHead_Dungeon1,
	FioleNecrolisAttivae,
	PotionVieMoyenne,
	PotionVieMajeur,
	GemmeRouge,
	GemmeVert,
	GemmeJaune,
	GemmeBleu,
	AnneauValthorion,
	Alliance,
	SkullHead_Dungeon2,
	CubeCopper,
	CubeSilver,
	CubeGold,
	SmallCog,
	LargeCog,
	DrawCompass,
	AnneauValthorionRestored,
}

func from(item_name : ItemName) -> Item :
	for item in get_children() :
		if item is Item :
			var i = item as Item
			if i.item_name == item_name :
				return i
	return null
