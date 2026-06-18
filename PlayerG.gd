class_name PlayerG
extends CharacterBody3D

enum State { ATTACK, MOVE, IDLE }

@onready var _character = $Rogue_Hooded as Node3D
@onready var _animation = $Rogue_Hooded/AnimationPlayer as AnimationPlayer
@onready var _atkTimer = $AtkTimer as Timer
@onready var _world = $/root/World as World

const _movement_speed: float = 4.0
const _max_range: float = 20
const _atk_range: float = 2

var _state : State = State.MOVE
var _dices = Dices.new()
var _attacked_monster : Monster

func _ready() -> void:
	$"Rogue_Hooded/Rig/Skeleton3D/handslot_r/Throwable".hide()
	$"Rogue_Hooded/Rig/Skeleton3D/handslot_r/1H_Crossbow".hide()
	$"Rogue_Hooded/Rig/Skeleton3D/handslot_r/2H_Crossbow".hide()
	$Rogue_Hooded/Rig/Skeleton3D/Rogue_Head_Hooded.hide()
	
func _physics_process(_delta: float) -> void:
	
	match _state :
		State.MOVE:
			if Input.is_action_just_released("attack") :
				if _world.target_monster and _world.target_monster.state == Monster.State.DEATH :
					pass # do loot
				if _world.target_monster and _world.target_monster.state != Monster.State.DEATH :
					_attacked_monster = _world.target_monster
					if self.global_position.distance_to(_attacked_monster.global_position) < _atk_range :
						_animation.play("Dualwield_Melee_Attack_Chop")
						_atkTimer.start(_animation.get_animation("Dualwield_Melee_Attack_Chop").length*.75)
						_state = State.ATTACK
						_character.rotation.y = get_viewport().get_camera_3d().rotation.y+deg_to_rad(180)
						velocity = Vector3.ZERO
			else : 
				_handle_move_input()
	
	move_and_slide()

func _handle_move_input() -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_front", "move_back")
	if input_dir :
		var cam_basis := get_viewport().get_camera_3d().get_global_transform().basis
		var direction := cam_basis * Vector3(input_dir.x, 0, input_dir.y)
		direction.y = 0
		direction = direction.normalized();
		if direction:
			velocity.x = direction.x * _movement_speed
			velocity.z = direction.z * _movement_speed
			_character.rotation.y = atan2(direction.x,direction.z)
			_animation.play("Walking_A")
		else:
			velocity = Vector3.ZERO
			_animation.play("Idle")
	else:
		velocity = Vector3.ZERO
		_animation.play("Idle")


func _on_atk_timer_timeout() -> void:
	var nb_atk = _dices.d6(2,4)
	_attacked_monster.receive_atk(nb_atk)
	_state = State.MOVE
