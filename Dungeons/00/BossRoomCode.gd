extends Node3D

@onready var _slot1 = $Slot1 as Node3D
@onready var _slot2 = $Slot2 as Node3D
@onready var _slot3 = $Slot3 as Node3D
@onready var _slot4 = $Slot4 as Node3D
@onready var _audio = $Audio as AudioStreamPlayer3D

func _on_action_1_activate() -> void:
	_toggle(_slot1, _slot2)

func _on_action_2_activate() -> void:
	_toggle(_slot2, _slot3)

func _on_action_3_activate() -> void:
	_toggle(_slot3, _slot4)
	
func _check() -> bool :
	var a = _slot1.get_children().get(0).name
	var b = _slot2.get_children().get(0).name
	var c = _slot3.get_children().get(0).name
	var d = _slot4.get_children().get(0).name
	return a == "orange" and b == "green" and c == "red" and d == "blue"

func _toggle(pos1:Node3D, pos2: Node3D) -> void :
	var a = pos1.get_children().get(0)
	var b = pos2.get_children().get(0)
	pos1.remove_child(a)
	pos2.remove_child(b)
	pos1.add_child(b)
	pos2.add_child(a)
	_audio.play()
	if _check() :
		$"../../SecretRoom".open()
	
