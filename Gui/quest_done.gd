extends GameBaseControl

func _ready() -> void:
	quest_book.quest_done.connect(_on_quest_done)
	hide()

func open() -> void :
	$AnimationPlayer.play("quest_done")
	$AudioStreamPlayer.play()

func _on_quest_done(_quest:Quest) -> void :
	print("_on_quest_done")
	open()
