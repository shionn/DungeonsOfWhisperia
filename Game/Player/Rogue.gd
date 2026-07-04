extends PlayerG


func _ready() -> void:
	$Character/Rig_Medium/Skeleton3D/Rogue_Head.hide()
	super._ready()

func get_def() -> int: 		return 2
func get_max_pv() -> int:	return 6
func get_atk_range()-> int:						return 2
func get_atk_animation() -> String: 			return "Melee_Dualwield_Attack_Chop"
func is_atk_dual_Hand() -> bool:				return true
func get_atk_main_hand() -> int:
	var atk = 2 if _attacked_monster._see_player else 3
	return Dices.d6(atk, 4)
func get_atk_main_hand_timer_factor() -> float: return .4
func get_atk_off_hand() -> int: 				return Dices.d6(2, 5)
func get_atk_off_hand_timer_factor() -> float:	return .7
