extends GameBase3D

@onready var _gun = $turret_base/turret_gun
@onready var _cold_down_timer = $ColdDownTimer

const _bullet_model = preload("res://Game/Player/EngineerTurretBullet.tscn")

const _FOV = deg_to_rad(45)
const _ROTATE_SPEED = .5
const _ATK_COLD_DOWN_TIME = 2

var _on_atk_cold_down = false

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var monster = _find_monster_to_atk()
	if monster : 
		_gun.look_at(monster.global_position+Vector3(0,.6,0), Vector3.UP, true)
		if not _on_atk_cold_down : _fire(monster)
	else : 
		_gun.rotation.y = _gun.rotation.y + delta * _ROTATE_SPEED

func _find_monster_to_atk() -> Monster :
	var monsters = get_tree().get_nodes_in_group("Monsters") as Array[Monster] 
	for monster in monsters : 
		if not monster.is_dead() : 
			var start = global_position+Vector3.UP
			var end = monster.global_position+Vector3.UP
			var direction = (end-start).normalized()
			var orientation = _gun.global_basis * Vector3.BACK
			if orientation.angle_to(direction) <= _FOV :
				var query = PhysicsRayQueryParameters3D.create(start, end, 1)
				var result = get_world_3d().direct_space_state.intersect_ray(query)
				if (result && result.collider == monster) :
					return monster
	return null

func _fire(monster : Monster) -> void :
	var distance = monster.distance_to(self) -.5
	var bullet : Node3D = _bullet_model.instantiate()
	$/root/World/Dungeon.add_child(bullet)
	bullet.position   = _gun.global_position + Vector3(0,.35,0)
	bullet.rotation.y = _gun.rotation.y - deg_to_rad(90)
	bullet.hit.connect(func():_hit(monster))
	var anim =  bullet.get_node("AnimationPlayer").get_animation("Fire") as Animation
	anim.track_set_key_value(0,1,Vector3(distance,0,0))
	bullet.get_node("AnimationPlayer").play("Fire", -1, 20.0/distance)
	_on_atk_cold_down = true
	_cold_down_timer.start(_ATK_COLD_DOWN_TIME)
	$Fire.play()

func _hit(monster : Monster) -> void : 
	#monster.receive_atk(Dices.d6(1,4))
	pass

func _on_cold_down_timer_timeout() -> void:
	_on_atk_cold_down = false
