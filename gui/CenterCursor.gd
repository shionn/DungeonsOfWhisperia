extends Control

@onready var _world = $"/root/World" as World
@onready var _player = $/root/World/Player as PlayerG

@onready var _cross = $Cross as Control
@onready var _sword = $Sword as Control
@onready var _magnifier = $Manifier as Control
@onready var _hand = $Hand as Control

const _tilt_limit = deg_to_rad(50)
const _mouse_sensitivity = 0.01
const _max_range: float = 20

func _physics_process(_delta: float) -> void:
	visible = Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and _player.pv > 0
	_cross.visible =     _world.target_monster == null and _world.target_interactable == null
	_sword.visible =     _world.target_monster != null && _world.target_monster.state != Monster.State.DEATH
	_magnifier.visible = _world.target_monster != null && _world.target_monster.state == Monster.State.DEATH
	_hand.visible = _world.target_interactable != null
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED :
		if abs(event.relative.y) > 50 or abs(event.relative.x) > 50 :
			return
		var camera = get_viewport().get_camera_3d()
		camera.rotation.x -= event.relative.y * _mouse_sensitivity
		camera.rotation.x = clampf(camera.rotation.x, -_tilt_limit, _tilt_limit)
		camera.rotation.y += -event.relative.x * _mouse_sensitivity
	if event is InputEventMouseButton and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		if (Input.mouse_mode == Input.MOUSE_MODE_CAPTURED) :
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else : 
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
