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
		print("menu")
		if $Options.visible :
			$Options.hide()
		elif $Introduction.visible :
			$Introduction.hide()
		elif $DialogGui.visible :
			$DialogGui.hide()
		elif $Bag.visible or $DialogGui.visible or $ExitAuberge.visible : 
			_close()
		else :
			_open()
	if player.velocity.x or player.velocity.z : 
		_close()

func openHelp(description: Dialog)  -> void :
	$Introduction.open(description)

func openLoot(container: Object) -> void :
	$Loot.loot(container)
	_open()

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

func _open() -> void : 
	$Bag.show()
	$Menu.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _close() -> void :
	$Bag.hide()
	$Loot.hide()
	$Menu.hide()
	$Introduction.hide()
	$DialogGui.hide()
	$Options.hide()
	$ExitAuberge.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_loot_visibility_changed() -> void:
	if not $Loot.visible and not $Introduction.visible : _close()

func _on_introduction_visibility_changed() -> void:
	print($Introduction.visible)
	if not $Introduction.visible and not $Bag.visible : 
		_close()

func _on_dialog_gui_visibility_changed() -> void:
	if not $DialogGui.visible and not $Bag.visible : _close()
	#if $DialogGui.visible : Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
