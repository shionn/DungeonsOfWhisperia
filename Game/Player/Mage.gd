extends PlayerG

const projectil_model = preload("res://Game/Player/Spells/ProjectilMagic.tscn")
const fireball_model = preload("res://Game/Player/Spells/FireBall.tscn")

enum AttackMode { CHOP, HORIZONTAL, DIAGONAL, PROJECTIL }
var _atk : AttackMode = AttackMode.CHOP

func _ready() -> void:
	$Character/Rig_Medium/Skeleton3D/Mage_Head.hide()
	$Character/Rig_Medium/Skeleton3D/Mage_Hat.hide()
	super._ready()

func _on_fireball_cast() -> void:
	var arrow : Node3D = fireball_model.instantiate() 
	$/root/World/Dungeon.add_child(arrow)
	arrow.target = _attacked_monster
	arrow.position = _character.global_position 

func _on_main_hand_atk_timer() -> void:
	if _atk == AttackMode.PROJECTIL :
		var arrow : Node3D = projectil_model.instantiate() 
		$/root/World/Dungeon.add_child(arrow)
		arrow.target = _attacked_monster
		arrow.position = _character.global_position 
	else : 
		super._on_main_hand_atk_timer()

func get_def() -> int: return 1+floori(lvl/2)
func get_max_pv() -> int:	return 4+lvl

func get_atk_range()-> float: return 20
func get_atk_animation() -> String: 
	# Dices._random.randi_range(0,2)
	_atk = Dices._random.randi_range(0,2)  as AttackMode if _attacked_monster.global_position.distance_to(global_position) <=2 else AttackMode.PROJECTIL
	match _atk :
		AttackMode.CHOP : return "Melee_1H_Attack_Chop"
		AttackMode.HORIZONTAL : return "Melee_1H_Attack_Slice_Horizontal"
		AttackMode.DIAGONAL : return "Melee_1H_Attack_Slice_Diagonal"
		AttackMode.PROJECTIL : return "Ranged_Magic_Shoot" #
		_ : return "Melee_1H_Attack_Chop"

func is_atk_dual_Hand() -> bool:				return false
func get_atk_main_hand() -> int:
	if _atk == AttackMode.PROJECTIL : return -1
		#eturn Dices.d6(lvl+1, 4) + 1
	return Dices.d6(1 + floori(lvl/2), 4)

func get_atk_main_hand_timer_factor() -> float: 
	match _atk :
		AttackMode.CHOP : return .55
		AttackMode.HORIZONTAL : return .2
		AttackMode.DIAGONAL : return .4
		AttackMode.PROJECTIL : return .3
		_ : return .55

func get_atk_off_hand() -> int: return 0
func get_atk_off_hand_timer_factor() -> float:	return 0
func get_player_classe(): return "Mage"
func get_spells(): return [$Fireball]
