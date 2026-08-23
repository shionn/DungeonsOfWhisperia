extends GameBase3D

@onready var _effect = $MProjectileBasicVFX_01
@onready var _explosion = $VFXHit_01
@onready var _explosion_animation = $VFXHit_01/AnimationPlayer

const SPEED = 10
var target : Monster

func _ready() -> void:
	_explosion_animation.animation_finished.connect(_on_explosion_animation_finished)
	$EffectAudio.play()

func _physics_process(delta: float) -> void:
	if _effect.visible :
		look_at(target.global_position, Vector3.UP, false)
		var vector = (target.global_position - position).normalized() * SPEED * delta
		position = position + vector
		if target.distance_to(self) < 1 : 
			target.receive_atk(_compute_dmg())
			_effect.hide()
			_explosion.show()
			_explosion_animation.play("main")
			$ExplosionAudio.play()

func _compute_dmg() -> int :
	return Dices.d6(player.lvl, 4)+1

func _on_explosion_animation_finished(_animation_name)-> void :
	queue_free()
