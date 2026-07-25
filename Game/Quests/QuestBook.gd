class_name QuestBook
extends GameBase

@onready var auberge_01 : Quest = $Auberge01
@onready var auberge_01_reprendre_des_forces : QuestObjectif = $"Auberge01/Reprendre des forces"
@onready var auberge_01_trouver_kkchos_a_faire : QuestObjectif = $"Auberge01/Trouver quelque chose à faire"

var _quests : Dictionary = {}
var current : Quest

func start(quest:Quest) -> bool :
	current = quest
	if not _quests.has(quest.name) :
		var q : Dictionary = {"done" : false}
		for obj in quest.list_objectif() :
			q.set(obj.name, {"done" : false})
		_quests.set(quest.name, q)
		return true
	return false

func is_done(quest:Quest, objectif: QuestObjectif = null) -> bool :
	var _q = (_quests.get(quest.name) as Dictionary)
	if objectif :
		return _q.get(objectif.name).get("done")
	return (_quests.get(quest.name) as Dictionary).get("done")

func done(quest:Quest, objectif: QuestObjectif = null) -> void :
	var _q = (_quests.get(quest.name) as Dictionary)
	if objectif :
		_q.get(objectif.name).set("done", true)
		if quest.is_all_done() : quest.done()
	else : 
		_q.set("done", true)
	
