class_name PlayerG
extends CharacterBody3D

@onready var _character = $Rogue_Hooded as Node3D
@onready var _animation = $Rogue_Hooded/AnimationPlayer as AnimationPlayer

var movement_speed: float = 4.0

func _ready() -> void:
	$"Rogue_Hooded/Rig/Skeleton3D/handslot_r/Throwable".hide()
	$"Rogue_Hooded/Rig/Skeleton3D/handslot_r/1H_Crossbow".hide()
	$"Rogue_Hooded/Rig/Skeleton3D/handslot_r/2H_Crossbow".hide()
	$Rogue_Hooded/Rig/Skeleton3D/Rogue_Head_Hooded.hide()
	
func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_front", "move_back")
	if input_dir :
		var cam_basis := get_viewport().get_camera_3d().get_global_transform().basis
		var direction := cam_basis * Vector3(input_dir.x, 0, input_dir.y)
		direction.y = 0
		direction = direction.normalized();
		if direction:
			velocity.x = direction.x * movement_speed
			velocity.z = direction.z * movement_speed
			_character.rotation.y = atan2(direction.x,direction.z)
			_animation.play("Walking_A")
		else:
			velocity = Vector3.ZERO
			_animation.play("Idle")
	else:
		velocity = Vector3.ZERO
		_animation.play("Idle")

	move_and_slide()

const tilt_limit = deg_to_rad(50)
const mouse_sensitivity = 0.01
var _previous_mouse_position : Vector2

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and Input.is_action_just_pressed("move_camera"):
		_previous_mouse_position = (event as InputEventMouseButton).position
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event is InputEventMouseButton and Input.is_action_just_released("move_camera") :
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Input.warp_mouse(_previous_mouse_position)
	elif event is InputEventMouseMotion and Input.is_action_pressed("move_camera"):
		var camera = get_viewport().get_camera_3d()
		camera.rotation.x -= event.relative.y * mouse_sensitivity
		camera.rotation.x = clampf(camera.rotation.x, -tilt_limit, tilt_limit)
		camera.rotation.y += -event.relative.x * mouse_sensitivity
