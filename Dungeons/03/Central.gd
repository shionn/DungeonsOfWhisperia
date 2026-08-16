extends Node3D


func _on_south_east_resolv() -> void:
	$Wall/wall_inset5/skull/Ruby_022/LootVFX_Mythic.show()


func _on_north_east_resolv() -> void:
	$Wall/wall_inset3/skull/Sapphire_012/LootVFX_Rare.show()


func _on_north_west_resolv() -> void:
	$Wall/wall_inset2/skull/Emerald_022/LootVFX_Uncommon.show()
