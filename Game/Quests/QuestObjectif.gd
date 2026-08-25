class_name QuestObjectif
extends GameBase

@export var secondary: bool = false
@export var xp: int = 5
@export var label: String : 
	get() :
		if label == null or label.is_empty() :
			return name
		return label
#@export var hidden: bool = false

func is_done() -> bool :
	return quest_book.is_done(_quest(), self)

func done() -> void : 
	if _quest().is_started() and not quest_book.is_done(_quest(), self) :
		quest_book.done(_quest(), self)
		if secondary : 
			gui.consoleLog("Objectif secondaire accompli : %s."%self.name)
			player.xp = player.xp + xp * player.lvl
		else :
			gui.consoleLog("Objectif accompli : %s."%self.name)
			if _quest().is_all_done() : _quest().done()

func _quest() -> Quest : return get_parent() as Quest
