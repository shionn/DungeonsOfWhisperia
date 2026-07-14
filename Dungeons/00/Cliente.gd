extends PNJ

func _ready() -> void:
	#$Character/Rig_Medium/Skeleton3D/Hoarder_Backpack.hide()
	$Character/Rig_Medium/Skeleton3D/Hoarder_CollarArmor.hide()
	$Character/Rig_Medium/Skeleton3D/Hoarder_FaceMask.hide()
	#$Character/Rig_Medium/Skeleton3D/Hoarder_FrontPouch.hide()
	#$Character/Rig_Medium/Skeleton3D/Hoarder_FrontPouch_Sword.hide()
	super._ready()
	
func interact() -> void:
	gui.openDialog($Dialog)

func drink() -> void:
	_animation.play("RigMedium/Use_Item")
	_animation.queue("RigMedium/Idle_A")

func player_know_about_mine() -> void:
	tags.add(Tags.AUBERGE_PLAYER_KNOW_MINE_UNDEAD)


func _on_drink_timer_timeout() -> void:
	drink()
	$DrinkTimer.start(Dices._random.randi_range(10,80))
