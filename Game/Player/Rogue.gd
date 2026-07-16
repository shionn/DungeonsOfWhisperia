extends PlayerG

enum AttackMode { CHOP, SLICE, STAB }
var _atk : AttackMode = AttackMode.STAB


func _ready() -> void:
	$Character/Rig_Medium/Skeleton3D/Rogue_Head.hide()
	super._ready()

func get_def() -> int: 		return 2 + floori(lvl/2)
func get_max_pv() -> int:	return 5+lvl
func get_atk_range()-> float:						return 2
func get_atk_animation() -> String: 
	_atk = Dices._random.randi_range(0,1) as AttackMode if _attacked_monster.see_player else AttackMode.STAB
	match _atk :
		AttackMode.CHOP : return "Melee_Dualwield_Attack_Chop"
		AttackMode.SLICE : return "Melee_Dualwield_Attack_Slice"
		AttackMode.STAB : return "Melee_Dualwield_Attack_Stab"
		_ : return "Melee_Dualwield_Attack_Chop"
		
func is_atk_dual_Hand() -> bool:				return true
func get_atk_main_hand() -> int:
	var deg = Dices.d6(1+lvl, 4)
	if _atk == AttackMode.STAB : deg = deg+1
	return deg
func get_atk_main_hand_timer_factor() -> float: 
	match _atk :
		AttackMode.CHOP : return .4
		AttackMode.SLICE : return .5
		AttackMode.STAB : return .3
		_ : return .4
func get_atk_off_hand() -> int: 				return Dices.d6(2, 5)
func get_atk_off_hand_timer_factor() -> float:	
	match _atk :
		AttackMode.CHOP : return .7
		AttackMode.SLICE : return .5
		AttackMode.STAB : return .3
		_ : return .4
func get_player_classe(): return "Rogue"
func get_spells(): return []
