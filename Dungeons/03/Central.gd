extends Node3D

@onready var _south_east_light = $Wall/wall_inset5/skull/Ruby_022/LootVFX_Mythic
@onready var _south_west_light = $Wall/wall_inset4/skull/Topaz_012/LootVFX_Legendary
@onready var _north_east_light = $Wall/wall_inset3/skull/Sapphire_012/LootVFX_Rare
@onready var _north_west_light = $Wall/wall_inset2/skull/Emerald_022/LootVFX_Uncommon

@onready var _portal = $GatePortalVFX_06

func _test_all() -> void : 
	if _south_east_light.visible and _south_west_light.visible and _north_east_light.visible and _north_west_light.visible :
		if _portal : _portal.queue_free()

func _on_south_east_resolv() -> void:
	_south_east_light.show()
	_test_all()

func _on_north_east_resolv() -> void:
	_north_east_light.show()
	_test_all()

func _on_north_west_resolv() -> void:
	_north_west_light.show()
	_test_all()

func _on_south_west_resolv() -> void:
	_south_west_light.show()
	_test_all()
