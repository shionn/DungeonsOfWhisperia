extends Monster

enum AttackMode { CHOP, CHOP_2H }

func get_fov() -> float : return 50
func get_rig() -> String : return "RigMedium/"
func get_def() -> int : return lvl
func get_hit_sound() -> AudioStreamPlayer3D : return $ZombieYell9
func get_max_pv() -> int : return lvl+1
func is_large() -> bool : return false
func get_global_colddown() -> float : return 2
func list_atks() -> Array[MonsterAtk] :  return [$Chop, $Chop2H]
func get_min_atk_range() -> int : return 2
