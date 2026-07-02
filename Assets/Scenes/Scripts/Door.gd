class_name Door
extends Interactable

@onready var door = $wall_doorway/wall_doorway_door
@onready var audioOpen = $AudioOpen
@onready var audioClose = $AudioClose

const PI_2 = PI / 2
const SPEED = 3

@export var open = false
@export var revert = false
@export var locked = false
@export var unlock_item : Items.ItemName

func on_interact() -> void:
	if locked :
		$LockAudio.play()
		gui.consoleLog("C'est fermé")
	else :
		open = not open
		if open : 
			audioOpen.play()
		else :
			audioClose.play()

func on_item_drop(item : Item)-> void:
	if item.item_name == unlock_item:
		$UnLockAudio.play()
		locked = false
		bag.unloot(item.item_name)
	else :
		super.on_item_drop(item)

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
