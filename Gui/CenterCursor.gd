extends GameBaseControl

@onready var _cross = $Cross as Control
@onready var _sword = $Sword as Control
@onready var _magnifier = $Manifier as Control
@onready var _hand = $Hand as Control
@onready var _disable = $Disabled as Control

const _tilt_limit = deg_to_rad(50)
const _mouse_sensitivity = 0.01
const _max_range: float = 20

func _physics_process(_delta: float) -> void:
	visible = Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and not player.isDead()
	
	_cross.visible = world.target_monster == null and world.target_interactable == null
	_sword.visible = world.target_monster != null and not world.target_monster.is_dead()
	
	_magnifier.visible = (
			world.target_monster      and world.target_monster.is_in_loot_range() and world.target_monster.is_dead()
		or 
			world.target_interactable and world.target_interactable.is_in_range() and world.target_interactable.action == Interactable.Action.LOOK
		)
	
	_hand.visible = world.target_interactable and world.target_interactable.is_in_range() and world.target_interactable.action == Interactable.Action.ACTIVATE
	
	_disable.visible = (
			world.target_interactable and not world.target_interactable.is_in_range()
		or 
			world.target_monster      and not world.target_monster.is_in_loot_range()      and world.target_monster.is_dead() 
		)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED :
		if abs(event.relative.y) > 50 or abs(event.relative.x) > 50 :
			return
		var camera = get_viewport().get_camera_3d()
		camera.rotation.x -= event.relative.y * _mouse_sensitivity
		camera.rotation.x = clampf(camera.rotation.x, -_tilt_limit, _tilt_limit)
		camera.rotation.y += -event.relative.x * _mouse_sensitivity
