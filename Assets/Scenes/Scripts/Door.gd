class_name Door
extends GameBase3D

@onready var door = $wall_doorway/wall_doorway_door
@onready var audioOpen = $AudioOpen
@onready var audioClose = $AudioClose

const PI_2 = PI / 2
const SPEED = 3

@export var open = false : 
	set(value) :
		open = value
		_update_navigation()
@export var revert = false
@export var locked = false
@export var unlock_item : Items.ItemName

signal player_enter()

func _ready() -> void:
	_update_navigation()

func _update_navigation() -> void:
	$NavigationRegion3D.enabled = open

func _on_knob_activate() -> void:
	if locked :
		$LockAudio.play()
		gui.consoleLog("C'est fermé")
	else :
		open = not open
		if open : 
			audioOpen.play()
		else :
			audioClose.play()

func _on_knob_item_drop(item: Item) -> void:
	if item.item_name == unlock_item:
		$UnLockAudio.play()
		locked = false
		bag.unloot(item.item_name)
	else :
		gui.consoleLog("Aucun effet.")


func _physics_process(delta: float) -> void:
	if open :
		if revert and door.rotation.y > -PI_2:
			door.rotation.y = max(door.rotation.y - delta*SPEED, -PI_2)
		elif not revert and door.rotation.y < PI_2 :
			door.rotation.y = min(door.rotation.y + delta*SPEED, PI_2)
	elif not open:
		if revert and door.rotation.y < 0 :
			door.rotation.y = min(door.rotation.y + delta*SPEED, 0)
		elif not revert and door.rotation.y > 0 :
			door.rotation.y = max(door.rotation.y - delta*SPEED, 0)

func _on_area_3d_body_shape_entered(_body_rid: RID, body: Node3D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body is PlayerG : player_enter.emit()
