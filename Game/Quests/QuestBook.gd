class_name QuestBook
extends GameBase

@onready var auberge_01 : Quest = $Auberge01
@onready var auberge_01_reprendre_des_forces : QuestObjectif = $"Auberge01/Reprendre des forces"

var _quests : Dictionary = {}

func start(quest:Quest) -> bool :
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
	_q.set("done", true)
	
