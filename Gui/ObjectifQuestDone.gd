extends GameBaseControl

var _objectif : QuestObjectif

func _ready() -> void:
	quest_book.objectif_done.connect(_on_quest_done)
	hide()

func open() -> void :
	$AnimationPlayer.play("quest_done")
	$AudioStreamPlayer.play()

func _on_quest_done(_quest:Quest, objectif : QuestObjectif) -> void :
	self._objectif = _objectif
	if objectif.secondary : 
		$Label.text= "Objectif secondaire accompli !\n%s" % objectif.name
	else :
		$Label.text= "Objectif accompli !\n%s" % objectif.name
	open()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	pass
