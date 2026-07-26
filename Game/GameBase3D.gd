extends Node3D
class_name GameBase3D

@onready var gui := $/root/World/Gui as Gui
@onready var player := $/root/World/Player as PlayerG
@onready var quest_book := $/root/World/Player/QuestBook as QuestBook
@onready var bag := $/root/World/Player/Bag as Bag
@onready var tags := $/root/World/Player/Tags as Tags

const LOOT_RANGE: float = 3
const GAME_VERSION: float = 0.2
