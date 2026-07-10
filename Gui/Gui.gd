extends GameBaseControl
class_name Gui

@onready var cursor = load("res://Gui/Assets/kenney/cursor-pack/pointer_c.png")
@onready var point_hand = load("res://Gui/Assets/kenney/cursor-pack/hand_point.png")
@onready var drag = load("res://Gui/Assets/kenney/cursor-pack/hand_closed.png")
@onready var can_drop = load("res://Gui/Assets/kenney/cursor-pack/hand_open.png")

func _ready() -> void:
	Input.warp_mouse(get_viewport().get_visible_rect().size/2)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	Input.set_custom_mouse_cursor(cursor,     Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(point_hand, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(drag,       Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(can_drop,   Input.CURSOR_CAN_DROP)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu") :
		if $Options.visible :
			$Options.hide()
		elif $Introduction.visible :
			$Introduction.hide()
		elif $DialogGui.visible :
			$DialogGui.hide()
		elif $Bag.visible or $DialogGui.visible or $ExitAuberge.visible : 
			_close()
		else :
			$Bag.show()
			$Menu.show()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if player.velocity.x or player.velocity.z : 
		_close()

func update_mouse_mode() -> void:
	if ($Options.visible or $Bag.visible 
			or $Loot.visible or $Introduction.visible 
			or $Options.visible or $DialogGui.visible
			or $ExitAuberge.visible) :
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else :
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func openHelp(description: Dialog)  -> void :
	$Introduction.open(description)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func openLoot(container: Object) -> void :
	$Loot.loot(container)
	$Bag.show()
	$Menu.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func openDialog(dialog: Dialog) -> void:
	$DialogGui.open(dialog)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func openAubergeExit() -> void:
	$ExitAuberge.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func openTransition(onMiddle : Callable) -> void:
	$Transition.doIt(onMiddle)

func consoleLog(text: String) -> void:
	$ConsoleLog.log(text)

func _close() -> void :
	$Bag.hide()
	$Loot.hide()
	$Menu.hide()
	$Introduction.hide()
	$DialogGui.hide()
	$Options.hide()
	$ExitAuberge.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_bag_visibility_changed() -> void:
	if not $Bag.visible : 
		$Loot.hide()
		update_mouse_mode()


func _on_loot_visibility_changed() -> void:
	if not $Loot.visible : 
		$Bag.hide()
		update_mouse_mode()
