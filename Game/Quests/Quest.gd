class_name Quest
extends GameBase

@export var title : String
@export_multiline() var description : String
@export var xp : int = 10

func start() -> bool :
	return quest_book.start(self)

func done() -> void :
	quest_book.done(self)
	gui.consoleLog("Quête accomplie : %s."%self.title)

func is_started() -> bool:
	return quest_book.is_started(self)

func is_done() -> bool :
	return quest_book.is_done(self)

func is_all_done() -> bool :
	var all_done = true
	for objectif in list_objectif() :
		all_done = all_done and (objectif.secondary or objectif.is_done())
	return all_done

func list_objectif() -> Array[QuestObjectif] :
	return get_children() as Array[QuestObjectif]
