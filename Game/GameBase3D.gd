extends Node3D
class_name GameBase3D

@onready var gui := $/root/World/Gui as Gui
@onready var player := $/root/World/Player as PlayerG
@onready var bag := $/root/World/Player/Bag as Bag

const LOOT_RANGE: float = 3
