class_name QuestObjectif
extends GameBase

func is_done() -> bool :
	return quest_book.is_done(_quest(), self)

func done() -> void : 
	if not quest_book.is_done(_quest(), self) :
		quest_book.done(_quest(), self)
		gui.consoleLog("Objectif accompli : %s."%self.name)
		
		
func _quest() -> Quest : return get_parent() as Quest
