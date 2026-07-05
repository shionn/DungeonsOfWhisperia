@abstract class_name PlayerG
extends CharacterBody3D

enum State { ATTACK, MOVE, IDLE, HIT, DEATH }

@onready var _character = $Character as Node3D
@onready var _animation = $Character/AnimationPlayer as AnimationPlayer
@onready var _world = $/root/World as World
@onready var _gui = $/root/World/Gui as Gui
@onready var _mainHandAtkTimer = $MainHandAtkTimer as Timer
@onready var _offHandAtkTimer = $OffHandAtkTimer as Timer

const _movement_speed: float = 4.0
const _max_range: float = 20
const _atk_range: float = 2

var _state : State = State.MOVE
var _attacked_monster : Monster

var lvl = 1
var pv = get_max_pv()

func _ready() -> void:
	_animation.animation_finished.connect(_on_animation_finished)
	_mainHandAtkTimer.timeout.connect(_on_main_hand_atk_timer)
	_offHandAtkTimer.timeout.connect(_on_off_hand_atk_timer)
	
func _physics_process(_delta: float) -> void:
	match _state :
		State.MOVE:
			if Input.is_action_just_released("interact") :
				if _world.target_monster and _world.target_monster.state == Monster.State.DEATH :
					pass # do loot
				if _world.target_monster and _world.target_monster.state != Monster.State.DEATH :
					_attacked_monster = _world.target_monster
					var _range = get_atk_range() + 1  if _attacked_monster.is_large() else get_atk_range()
					if self.global_position.distance_to(_attacked_monster.global_position) < _range  :
						_start_atk()
			else : 
				_handle_move_input()
		State.HIT: velocity = Vector3.ZERO
		State.DEATH: velocity = Vector3.ZERO
	
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
			_start_animation("Walking_A")
		else:
			velocity = Vector3.ZERO
			_start_animation("Idle_A")
	else:
		velocity = Vector3.ZERO
		_start_animation("Idle_A")

func receive_atk(nb_atk: int, monster:Monster) -> void:
	var nb_def = Dices.d6(get_def(), 5)
	var deg = nb_atk - nb_def
	if nb_atk > 0 :
		_gui.consoleLog("%s obtient %d 💀, vous obtenez %d 🛡" % [monster.name, nb_atk, nb_def])
	else :
		_gui.consoleLog("%s obtient %d 💀" % [monster.name, nb_atk])
		
	if deg > 0 :
		$HumanYell3.play()
		pv = max(pv - deg, 0)
		if pv > 0:
			_start_animation("Hit_A")
			_state = State.HIT
		else :
			_start_animation("Death_A")
			_state = State.DEATH

func _start_atk() -> void:
	var duration = _start_animation(get_atk_animation())
	_mainHandAtkTimer.start(duration*get_atk_main_hand_timer_factor())
	if is_atk_dual_Hand() : _offHandAtkTimer.start(duration*get_atk_off_hand_timer_factor())
	_character.rotation.y = get_viewport().get_camera_3d().rotation.y+PI
	_state = State.ATTACK
	velocity = Vector3.ZERO

func _on_main_hand_atk_timer() -> void:
	var nb_atk = get_atk_main_hand()
	_attacked_monster.receive_atk(nb_atk)
	$Swing3.play()

func _on_off_hand_atk_timer() -> void:
	var nb_atk = get_atk_off_hand()
	_attacked_monster.receive_atk(nb_atk)
	$Swing3.play()

func _start_animation(anim_name:String) -> float:
	var animation =  "RigMedium/"  + anim_name
	var duration = _animation.get_animation(animation).length
	_animation.play(animation)
	return duration

func _on_animation_finished(_anim_name : String) -> void:
	match _state :
		State.ATTACK:
			_state = State.MOVE
		State.HIT :
			_state = State.MOVE

func isDead() -> bool: return _state == State.DEATH or pv <= 0
func distance_to(target:Node3D) -> float :
	return global_position.distance_to(target.global_position)

@abstract func get_def() -> int
@abstract func get_max_pv() -> int
@abstract func get_atk_range() -> int
@abstract func get_atk_animation() -> String
@abstract func is_atk_dual_Hand() -> bool
@abstract func get_atk_main_hand() -> int
@abstract func get_atk_main_hand_timer_factor() -> float
@abstract func get_atk_off_hand() -> int
@abstract func get_atk_off_hand_timer_factor() -> float
