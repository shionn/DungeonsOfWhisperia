extends PlayerG

enum AttackMode { CHOP, SLICE }
var _atk : AttackMode = AttackMode.SLICE

func _ready() -> void:
	$Character/Rig_Medium/Skeleton3D/Barbarian_Head.hide()
	$Character/Rig_Medium/Skeleton3D/Barbarian_BearHat.hide()
	super._ready()

func get_def() -> int: 		return 2
func get_max_pv() -> int:	return 9
func get_atk_range()-> int:						return 2
func get_atk_animation() -> String: 
	_atk = Dices._random.randi_range(0, 1) as AttackMode
	match _atk :
		AttackMode.CHOP : return "Melee_2H_Attack_Chop"
		AttackMode.SLICE : return "Melee_2H_Attack_Slice"
		_ : return "Melee_2H_Attack_Chop"
func is_atk_dual_Hand() -> bool:				return false
func get_atk_main_hand() -> int:				return Dices.d6(3, 4)
func get_atk_main_hand_timer_factor() -> float: 
	match _atk :
		AttackMode.CHOP : return .5
		AttackMode.SLICE : return .4
		_ : return .5
func get_atk_off_hand() -> int: 				return Dices.d6(3, 5)
func get_atk_off_hand_timer_factor() -> float:	return 0
func get_player_classe(): return "Barbarian"
