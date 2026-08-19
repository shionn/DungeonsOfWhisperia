extends GameBase3D

@onready var black_knight = $BlackKnight
@onready var valthorion = $Valthorion

var entered = false


func _on_area_3d_body_shape_entered(_body_rid: RID, body: Node3D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body is PlayerG and not entered :
		gui.openDialog($Cinematique)
		entered = true


func _on_non_close() -> void:
	black_knight.state = Monster.State.IDLE

func _on_cinematique_2_activate() -> void:
	valthorion._navigation_agent.navigation_finished.connect(_navigation_finish)
	valthorion.navitage_to($arch2.global_position)

func _navigation_finish() -> void:
	valthorion.queue_free()
	$arch2/teleport.play()

func _on_black_knight_dead() -> void:
	$DeadDelay.start()

func _on_dead_delay_timeout() -> void:
	gui.openDialog($Cinematique2)

func _on_autel_item_drop(_item: Item) -> void:
	if _item.item_name == Items.ItemName.AnneauValthorion :
		$Autel/Axes/Gold_Gem_Ring_032.show()
		bag.unloot(Items.ItemName.AnneauValthorion)
		$Autel/Axes/Gold_Gem_Ring_032.loot_obj = Items.ItemName.AnneauValthorionRestored
		
	pass # Replace with function body.
