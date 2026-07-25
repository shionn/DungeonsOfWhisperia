class_name Quest
extends GameBase

@export var title : String

func start() -> bool :
	return quest_book.start(self)

func list_objectif() -> Array[QuestObjectif] :
	return get_children() as Array[QuestObjectif]
