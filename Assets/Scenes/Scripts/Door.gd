class_name Door
extends Interactable

@onready var door = $wall_doorway/wall_doorway_door

const PI_2 = PI / 2
const SPEED = 3

@export var open = false
@export var revert = false

func on_interact() -> void:
	open = not open

func _physics_process(delta: float) -> void:
	if open :
		if revert and door.rotation.y > -PI_2:
			door.rotation.y = max(door.rotation.y - delta*SPEED, -PI_2)
			_area.rotation.y = door.rotation.y
		elif not revert and door.rotation.y < PI_2 :
			door.rotation.y = min(door.rotation.y + delta*SPEED, PI_2)
			_area.rotation.y = door.rotation.y
	elif not open:
		if revert and door.rotation.y < 0 :
			door.rotation.y = min(door.rotation.y + delta*SPEED, 0)
			_area.rotation.y = door.rotation.y
		elif not revert and door.rotation.y > 0 :
			door.rotation.y = max(door.rotation.y - delta*SPEED, 0)
			_area.rotation.y = door.rotation.y
