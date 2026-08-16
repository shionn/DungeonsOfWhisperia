extends GameBase3D


func _on_switch_1_item_place(plate: PressurePlate, item: Item) -> void:
	if item.cube : 
		_place(plate, item)
		if item.item_name == Items.ItemName.CubeCopper : plate.toggle_down()
		else : plate.toggle_down_deep()
	else :
		pass


func _on_switch_2_item_place(plate: PressurePlate, item: Item) -> void:
	if item.cube : 
		_place(plate, item)
		if item.item_name == Items.ItemName.CubeSilver : plate.toggle_down()
		elif item.item_name == Items.ItemName.CubeGold : plate.toggle_down_deep()
	else :
		pass


func _on_switch_3_item_place(plate: PressurePlate, item: Item) -> void:
	if item.cube : 
		_place(plate, item)
		if item.item_name == Items.ItemName.CubeGold : plate.toggle_down()
	else :
		pass # Replace with function body.


func _on_switch_4_item_place(plate: PressurePlate, item: Item) -> void:
	if item.cube : 
		_place(plate, item)
		if item.item_name == Items.ItemName.CubeGold : plate.toggle_down()

func _place(plate: PressurePlate, item: Item) -> void : 
	var g = _instanciate_model(item)
	g.position.y = 0.05
	plate.add_child(g)
	bag.unloot(item.item_name)


func _instanciate_model(item: Item) -> Node3D :
	match item.item_name :
		Items.ItemName.CubeCopper : return preload("res://Assets/Scenes/Lootable_Copper_Cube.tscn").instantiate()
		Items.ItemName.CubeSilver : return preload("res://Assets/Scenes/Lootable_Silver_Cube.tscn").instantiate()
		Items.ItemName.CubeGold : return preload("res://Assets/Scenes/Lootable_Gold_Cube.tscn").instantiate()
		_ : return null


func _on_switch_activate(_plate: PressurePlate) -> void:
	var enable = true
	for node in get_children() :
		if node is PressurePlate :
			enable = enable and node.is_toggle()
	if enable :
		$Wall/wall_cracked3/Emerald_022/GroundLootVFX_Uncommon.show()
