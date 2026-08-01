extends Control
class_name GameBaseControl

@onready var world := $/root/World as World
@onready var gui := $/root/World/Gui as Gui
@onready var player := $/root/World/Player as PlayerG
@onready var quest_book := $/root/World/Player/QuestBook as QuestBook
@onready var bag := $/root/World/Player/Bag as Bag
@onready var tags := $/root/World/Player/Tags as Tags
@onready var options := $/root/World/Options as Options

const LOOT_RANGE = 3.0
