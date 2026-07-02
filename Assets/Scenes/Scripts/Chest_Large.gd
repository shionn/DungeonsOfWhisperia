extends GameBase

@onready var _lid = $chest_large/chest_large_lid

@export var locked = true
@export var unlock_item : Items.ItemName = Items.ItemName.ClefCoffre
@export var loot_obj : Items.ItemName = Items.ItemName.None
@export var loot_gold = 131 :
	set(value):
		loot_gold = value
		if (value == 0) : $chest_large/coin_stack_large.queue_free()

const SPEED = 2

var open = false

func _physics_process(delta: float) -> void:
	if open and _lid.rotation.x > deg_to_rad(-60):
		_lid.rotation.x = max(_lid.rotation.x - delta*SPEED, deg_to_rad(-60))
	elif not open and _lid.rotation.x < 0:
		_lid.rotation.x = min(_lid.rotation.x + delta*SPEED, 0)

func _on_item_drop(_item: Item) -> void:
	if _item.item_name == unlock_item :
		locked = false
		open = true
		$UnLockAudio.play()
		bag.unloot(_item.item_name)
	else :
		$LockAudio.play()
		gui.consoleLog("C'est sans effet")

func _on_activate() -> void:
	if locked :
		$LockAudio.play()
		gui.consoleLog("C'est fermé")
	else :
		open = !open


func _on_coin_stack_large_activate() -> void:
	gui.openLoot(self)
