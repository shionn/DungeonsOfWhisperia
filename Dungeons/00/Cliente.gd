extends PNJ

func _ready() -> void:
	#$Character/Rig_Medium/Skeleton3D/Hoarder_Backpack.hide()
	$Character/Rig_Medium/Skeleton3D/Hoarder_CollarArmor.hide()
	$Character/Rig_Medium/Skeleton3D/Hoarder_FaceMask.hide()
	#$Character/Rig_Medium/Skeleton3D/Hoarder_FrontPouch.hide()
	#$Character/Rig_Medium/Skeleton3D/Hoarder_FrontPouch_Sword.hide()
	super._ready()
	if quest_book.auberge_03_randre_alliance.is_done() :
		queue_free()
	
func interact() -> void:
	look_at_player()
	$"Dialog/Enigme passage Secret ?".enable = tags.have(Tags.DUNGEON_02_VISIT_CULT_ROOM)
	$Dialog/Alliance.enable = bag.have(Items.ItemName.Alliance)
	gui.openDialog($Dialog)

func drink() -> void:
	_animation.play("RigMedium/Use_Item")
	_animation.queue("RigMedium/Idle_A")

func player_know_about_mine() -> void:
	tags.add(Tags.AUBERGE_PLAYER_KNOW_SHADOW_CHASM)


func _on_drink_timer_timeout() -> void:
	drink()
	$DrinkTimer.start(Dices._random.randi_range(10,35))

func _on_alliance_next_activate() -> void:
	bag.unloot(Items.ItemName.Alliance)
	quest_book.auberge_03_randre_alliance.done()
