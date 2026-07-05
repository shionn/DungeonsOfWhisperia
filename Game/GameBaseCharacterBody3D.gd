extends CharacterBody3D
class_name GameBaseCharacterBody3D

@onready var world := $/root/World as World
@onready var gui := $/root/World/Gui as Gui
@onready var player := $/root/World/Player as PlayerG
@onready var bag := $/root/World/Player/Bag as Bag

const LOOT_RANGE: float = 3

func distance_to(target:Node3D) -> float :
	return global_position.distance_to(target.global_position)
