extends GameBaseControl

var _quest : Quest

func _ready() -> void:
	quest_book.quest_done.connect(_on_quest_done)
	hide()

func open() -> void :
	$AnimationPlayer.play("quest_done")
	$AudioStreamPlayer.play()

func _on_quest_done(quest:Quest) -> void :
	self._quest = quest
	open()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	player.xp = player.xp + _quest.xp
