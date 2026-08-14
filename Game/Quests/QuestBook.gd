class_name QuestBook
extends GameBase

@onready var auberge_01 : Quest = $Auberge01
@onready var auberge_01_reprendre_des_forces : QuestObjectif = $"Auberge01/Reprendre des forces"
@onready var auberge_01_trouver_kkchos_a_faire : QuestObjectif = $"Auberge01/Trouver quelque chose à faire"
@onready var dungeon_01 : Quest = $Dungeon01
@onready var dungeon_01_kill_boss : QuestObjectif = $"Dungeon01/Vaincre le maître des lieux"
@onready var dungeon_01_have_proof : QuestObjectif = $"Dungeon01/Rapporter une preuve de votre réussite"
@onready var dungeon_01_have_potion : QuestObjectif = $"Dungeon01/Trouver un indice sur l'origine de ces morts-vivant"
@onready var dungeon_01_treasur_found : QuestObjectif = $"Dungeon01/Trouver le trésors"
@onready var auberge_02 : Quest = $Auberge02
@onready var auberge_02_recevoir_prime : QuestObjectif = $"Auberge02/Recevoir sa prime"
@onready var auberge_02_trouver_mission : QuestObjectif = $"Auberge02/Trouver une autre mission"
@onready var auberge_02_identifier_potion : QuestObjectif = $"Auberge02/Faire identifier la potion"
@onready var auberge_02_connaitre_valthorion : QuestObjectif = $"Auberge02/En apprendre plus sur Valthorion"
@onready var dungeon_02 : Quest = $Dungeon02
@onready var dungeon_02_trouver_passage_secret : QuestObjectif = $"Dungeon02/Trouver le passage secret"
@onready var dungeon_02_identifier_valthorion : QuestObjectif = $"Dungeon02/Identifier le maitre de ces lieux"
@onready var dungeon_02_kill_boss : QuestObjectif = $"Dungeon02/Vaincre le maître des lieux"
@onready var dungeon_02_preuve_kill_boss : QuestObjectif = $"Dungeon02/Rapporter une preuve de votre réussite"
@onready var dungeon_02_preuve_valthorion : QuestObjectif = $"Dungeon02/Trouver un objet identifiant le maitre des lieux"
@onready var dungeon_02_trouver_alliance : QuestObjectif = $"Dungeon02/Trouver l'aliance"
@onready var dungeon_02_trouver_nom_aelthara : QuestObjectif = $"Dungeon02/Trouver l'ancien nom du gouffre"
@onready var auberge_03 : Quest = $Auberge03
@onready var auberge_03_rapport : QuestObjectif = $"Auberge03/Faire son rapport"
@onready var auberge_03_identify_ring : QuestObjectif = $"Auberge03/Identifier la Bague"
@onready var auberge_03_trouver_mission : QuestObjectif = $"Auberge03/Trouver une autre mission"
@onready var auberge_03_randre_alliance : QuestObjectif = $"Auberge03/Rendre l'alliance"


var _quests : Dictionary = {}
var current : Quest

signal quest_done(quest:Quest)
signal objectif_done(quest:Quest, objectif: QuestObjectif)

func start(quest:Quest) -> bool :
	current = quest
	if not _quests.has(quest.name) :
		var q : Dictionary = {"done" : false}
		for obj in quest.list_objectif() :
			q.set(obj.name, {"done" : false})
		_quests.set(quest.name, q)
		return true
	return false

func is_started(quest:Quest) -> bool:
	return _quests.has(quest.name)

func is_done(quest:Quest, objectif: QuestObjectif = null) -> bool :
	if not is_started(quest) : return false
	var _q = (_quests.get(quest.name) as Dictionary)
	if objectif :
		return _q.get(objectif.name).get("done")
	return (_quests.get(quest.name) as Dictionary).get("done")

func done(quest:Quest, objectif: QuestObjectif = null) -> void :
	var _q = (_quests.get(quest.name) as Dictionary)
	if objectif :
		objectif_done.emit(quest, objectif)
		_q.get(objectif.name).set("done", true)
	else : 
		quest_done.emit(quest)
		_q.set("done", true)
	
