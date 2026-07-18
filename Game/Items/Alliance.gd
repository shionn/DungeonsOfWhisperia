extends Item


func lootable() -> bool:
	return super.lootable() and not tags.have(Tags.AUBERGE_ALLIANCE_RETURNED)
