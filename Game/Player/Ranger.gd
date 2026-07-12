extends PlayerG

const arrow_model = preload("res://Game/Player/Arrow.tscn")
enum AttackMode { CHOP, HORIZONTAL, DIAGONAL, BOW }
var _atk : AttackMode = AttackMode.CHOP

@onready var _arrow = $Character/Rig_Medium/Skeleton3D/RightHand/Arrow
@onready var _dague = $Character/Rig_Medium/Skeleton3D/RightHand/Dagger

func _ready() -> void:
	$Character/Rig_Medium/Skeleton3D/Ranger_Head.hide()
	_arrow.hide()
	super._ready()
	
func _on_animation_finished(_anim_name : String) -> void:
	if _anim_name.ends_with("/Ranged_Bow_Draw"):
		var arrow : Node3D = arrow_model.instantiate()
		$/root/World/Dungeon.add_child(arrow)
		arrow.position   = _character.global_position 
		arrow.rotation.y = _character.rotation.y
		arrow.get_node("AnimationPlayer").play("Launch")
		_arrow.hide()
	super._on_animation_finished(_anim_name)

func get_def() -> int: 		return 2
func get_max_pv() -> int:	return 6
func get_atk_range()-> int: return 20
func get_atk_animation() -> String: 
	_atk = Dices._random.randi_range(0,2) as AttackMode if _attacked_monster.global_position.distance_to(global_position) <=2 else AttackMode.BOW
	match _atk :
		AttackMode.CHOP :       
			_dague.show()
			_arrow.hide()
			return "Melee_1H_Attack_Chop"
		AttackMode.HORIZONTAL : 
			_dague.show()
			_arrow.hide()
			return "Melee_1H_Attack_Slice_Horizontal"
		AttackMode.DIAGONAL :   
			_dague.show()
			_arrow.hide()
			return "Melee_1H_Attack_Slice_Diagonal"
		AttackMode.BOW :        
			_dague.hide()
			_arrow.show()
			return "Ranged_Bow_Draw"
		_ : return "Melee_1H_Attack_Chop"
		
func is_atk_dual_Hand() -> bool: return false
func get_atk_main_hand() -> int:
	var deg = Dices.d6(2, 4) 
	if _atk == AttackMode.BOW : deg = deg + 1
	return deg
func get_atk_main_hand_timer_factor() -> float: 
	match _atk :
		AttackMode.CHOP : return .55
		AttackMode.HORIZONTAL : return .2
		AttackMode.DIAGONAL : return .4
		AttackMode.BOW : return 1.1
		_ : return .55
func get_atk_off_hand() -> int: return 0
func get_atk_off_hand_timer_factor() -> float: return 0
func get_player_classe(): return "Ranger"
func get_spells(): return []
