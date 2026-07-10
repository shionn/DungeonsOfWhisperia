
class_name PNJ
extends GameBaseCharacterBody3D

@onready var _animation = $Character/AnimationPlayer as AnimationPlayer
@onready var _name_label = $Label3D as Label3D

@export var interact_distance = 3.0

func _ready() -> void:
	_animation.play("RigMedium/Idle_A")
	_name_label.text = name
	
	
func _physics_process(_delta: float) -> void:
	_name_label.look_at(player.global_position, Vector3.UP, true)

func interact() -> void:
	print("interact is not overwrite")

func look_at_player() -> void:
	self.look_at(player.global_position, Vector3.UP, true)

func is_in_range() -> bool :
	return player.distance_to(self) <= interact_distance
