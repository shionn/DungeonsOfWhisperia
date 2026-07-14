extends PNJ

func interact() -> void:
	look_at_player()
	gui.openDialog($Bienvenue)

func _buy(price : int, item : Items.ItemName ) -> void :
	if bag.gold >= price :
		bag.gold = bag.gold - price
		bag.loot(item)
		gui.openDialog($"Achat validé")
	else :
		gui.openDialog($ManquePo)

func _on_acheter_next_activate() -> void:
	_animation.play("RigMedium/Cheering")
	_animation.queue("RigMedium/Idle_A")

func _on_potion_de_soin_mineur_activate() -> void:
	_buy(50, Items.ItemName.PotionVieMineur )

func _on_potion_de_soin_moyenne_activate() -> void:
	_buy(100, Items.ItemName.PotionVieMoyenne )

func _on_potion_de_soin_majeur_activate() -> void:
	_buy(150, Items.ItemName.PotionVieMajeur )
