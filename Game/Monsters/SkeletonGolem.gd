extends Monster

enum AttackMode { CHOP, CHOP_2H }

func _ready() -> void:
	super._ready()
	match weapon :
		Weapon.COG : $Character/Rig_Large/Skeleton3D/RightHand/Skeleton_Mace_Large.queue_free()
		Weapon.DEFAULT: $Character/Rig_Large/Skeleton3D/RightHand/Parts_Cog_Large.queue_free()

func get_fov() -> float : return 50
func get_rig() -> String : return "RigLarge/"
func get_def() -> int : return 2+lvl
func get_hit_sound() -> AudioStreamPlayer3D : return $ZombieYell8
func get_max_pv() -> int : return 3+lvl
func is_large() -> bool : return true
func get_global_colddown() -> float : return 2
func list_atks() -> Array[MonsterAtk] :  return [$Slash, $TwoHand, $TwoHandSlam]
func get_min_atk_range() -> int : return 2
