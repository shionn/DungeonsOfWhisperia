extends Node3D


func _on_token_switch_state_change(token: FlipTokenSwitch) -> void:
	var x = token.name.substr(0,1).to_int()
	var y = token.name.substr(1,1).to_int()
	if x > 1 : _toggle(x-1, y)
	if x < 5 : _toggle(x+1, y)
	if y > 1 : _toggle(x, y-1)
	if y < 5 : _toggle(x, y+1)
	
	if all_white() or all_black() :
		$Ruby_012/LootVFX_Mythic.show()
	

func _toggle(x:int, y:int) -> void:
	get_node("%d%d"%[x,y]).toggle()
	
func all_white() -> bool :
	for child in get_children() :
		if child is FlipTokenSwitch and not child.state : return false
	return true

func all_black() -> bool :
	for child in get_children() :
		if child is FlipTokenSwitch and child.state : return false
	return true
