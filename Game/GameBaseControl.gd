extends Control
class_name GameBaseControl

@onready var world := $/root/World as World
@onready var gui := $/root/World/Gui as Gui
@onready var bag := $/root/World/Player/Bag as Bag
@onready var player := $/root/World/Player as PlayerG

const LOOT_RANGE = 3.0
