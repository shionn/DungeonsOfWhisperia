extends PlayerG


func _ready() -> void:
	$Character/Rig_Medium/Skeleton3D/RogueHooded_Head.hide()
	$Character/Rig_Medium/Skeleton3D/RogueHooded_Mask.hide()
	super._ready()

func get_def() -> int: 		return 2
func get_max_pv() -> int:	return 6
func get_atk_range()-> int:						return 2
func get_atk_animation() -> String: 			return "Melee_Dualwield_Attack_Chop"
func get_atk_main_hand() -> int:				return 2
func get_atk_main_hand_timer_factor() -> float: return .4
func get_atk_off_hand() -> int:					return 2
func get_atk_off_hand_timer_factor() -> float:	return .7
