
class_name PNJ
extends GameBaseCharacterBody3D

@onready var _animation = $Character/AnimationPlayer as AnimationPlayer

@export var interact_distance = 3.0

func _ready() -> void:
	_animation.play("RigMedium/Idle_A")
	
func interact() -> void:
	print("interact is not overwrite")

func is_in_range() -> bool :
	return player.distance_to(self) <= interact_distance
