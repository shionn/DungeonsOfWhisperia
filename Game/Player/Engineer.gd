extends PlayerG

const _turret_model = preload("res://Game/Player/Spells/EngineerTurret.tscn")

enum AttackMode {CHOP, HORIZONTAL, DIAGONAL}

var _atk : AttackMode = AttackMode.DIAGONAL

func _ready() -> void:
	$Character/Rig_Medium/Skeleton3D/Engineer_Head.hide()
	$Character/Rig_Medium/Skeleton3D/Engineer_Goggles.hide()
	$Character/Rig_Medium/Skeleton3D/RightHand/paladin_hammer2.queue_free()
	super._ready()

func get_def() -> int: 		return 1+lvl
func get_max_pv() -> int:	return 5+lvl
func get_atk_range()-> float:return 2
func get_atk_animation() -> String: 
	_atk = Dices._random.randi_range(0, 2) as AttackMode
	match _atk :
		AttackMode.CHOP : return "Melee_1H_Attack_Chop"
		AttackMode.HORIZONTAL : return "Melee_1H_Attack_Slice_Horizontal"
		AttackMode.DIAGONAL : return "Melee_1H_Attack_Slice_Diagonal"
		_ : return "Melee_1H_Attack_Chop"
func is_atk_dual_Hand() -> bool:				return false
func get_atk_main_hand() -> int:				return Dices.d6(1 + floori(lvl/2), 4)
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


func _on_invoquer_tourelle_cast() -> void:
	var _turret =  _turret_model.instantiate()
	_turret.position   = self.global_position +_character.global_basis * Vector3.BACK
	$/root/World/Dungeon.add_child(_turret)
