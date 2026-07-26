class_name QuestObjectif
extends GameBase

@export var hidden: bool = false

func is_done() -> bool :
	return quest_book.is_done(_quest(), self)

func done() -> void : 
	if not quest_book.is_done(_quest(), self) :
		quest_book.done(_quest(), self)
		gui.consoleLog("Objectif secondaire accompli : %s."%self.name)
		if not hidden and _quest().is_all_done() : _quest().done()

func _quest() -> Quest : return get_parent() as Quest
