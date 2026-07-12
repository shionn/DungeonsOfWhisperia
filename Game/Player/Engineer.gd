extends PlayerG

enum AttackMode {CHOP, HORIZONTAL, DIAGONAL}
var _atk : AttackMode = AttackMode.DIAGONAL

func _ready() -> void:
	$Character/Rig_Medium/Skeleton3D/Engineer_Head.hide()
	$Character/Rig_Medium/Skeleton3D/Engineer_Goggles.hide()
	super._ready()

func get_def() -> int: 		return 2
func get_max_pv() -> int:	return 6
func get_atk_range()-> int:						return 2
func get_atk_animation() -> String: 
	_atk = Dices._random.randi_range(0, 2) as AttackMode
	match _atk :
		AttackMode.CHOP : return "Melee_1H_Attack_Chop"
		AttackMode.HORIZONTAL : return "Melee_1H_Attack_Slice_Horizontal"
		AttackMode.DIAGONAL : return "Melee_1H_Attack_Slice_Diagonal"
		_ : return "Melee_1H_Attack_Chop"
func is_atk_dual_Hand() -> bool:				return false
func get_atk_main_hand() -> int:				return Dices.d6(2, 4)
func get_atk_main_hand_timer_factor() -> float: 
	match _atk :
		AttackMode.CHOP : return .55
		AttackMode.HORIZONTAL : return .2
		AttackMode.DIAGONAL : return .4
		_ : return .6
func get_atk_off_hand() -> int: 				return 0
func get_atk_off_hand_timer_factor() -> float:	return 0
func get_player_classe(): return "Engineer"
func get_spells(): return [$"Invoquer Tourelle"]
