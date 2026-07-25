class_name Quest
extends GameBase

@export var title : String
@export_multiline() var description : String

func start() -> bool :
	return quest_book.start(self)

func done() -> void :
	quest_book.done(self)
	gui.consoleLog("Quête accomplie : %s."%self.title)

func is_done() -> bool :
	return quest_book.is_done(self)

func is_all_done() -> bool :
	var all_done = true
	for objectif in list_objectif() :
		all_done = all_done and (objectif.hidden or objectif.is_done())
	return all_done

func list_objectif() -> Array[QuestObjectif] :
	return get_children() as Array[QuestObjectif]
