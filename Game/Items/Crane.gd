extends Item

func lootable() -> bool: 
	return super.lootable() and not tags.have(Tags.DUNGEON_01_FINISHED)
