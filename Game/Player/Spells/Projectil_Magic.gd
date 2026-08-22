extends GameBase3D

@onready var effect = $MProjectileBasicVFX_01

const SPEED = 10
var target : Monster

func _physics_process(delta: float) -> void:
	look_at(target.global_position, Vector3.UP, false)
	var vector = (target.global_position - position).normalized() * SPEED * delta
	position = position + vector
	if target.distance_to(self) < 1 : 
		var dmg = Dices.d6(player.lvl, 4)+1
		target.receive_atk(dmg)
		queue_free()
	
