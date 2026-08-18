extends GameBase3D

@onready var _sign_33 = $sign_33
@onready var _sign_43 = $sign_43

func updade_lights() -> void :
	_sign_33.updade_light()
	_sign_43.updade_light()
	
	if _sign_33.is_good() and _sign_43.is_good() :
		$plaque2/Sapphire_022/LootVFX_Rare.show()
		quest_book.dungeon_03_resoudre_lumiere.done()
