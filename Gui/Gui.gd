extends GameBaseControl
class_name Gui

@onready var cursor = load("res://Gui/Assets/kenney/cursor-pack/pointer_c.png")
@onready var point_hand = load("res://Gui/Assets/kenney/cursor-pack/hand_point.png")
@onready var drag = load("res://Gui/Assets/kenney/cursor-pack/hand_closed.png")
@onready var can_drop = load("res://Gui/Assets/kenney/cursor-pack/hand_open.png")

@onready var _options = $Options as GridContainer
@onready var _introduction = $Introduction as GridContainer
@onready var _dialog = $DialogGui as GridContainer
@onready var _bag = $Bag as GridContainer
@onready var _exit_auberge = $ExitAuberge as GridContainer
@onready var _exit_dungeon = $ExitDungeon as GridContainer
@onready var _game_over = $GameOver as Control
@onready var _menu = $Menu as MenuButton
@onready var _loot = $Loot as GridContainer
@onready var _spells = $Spells as HBoxContainer                                                                                                                                                                                             
@onready var _console = $ConsoleLog as RichTextLabel          
@onready var _transition = $Transition as Transition                                                                                                                                                                      

var _previous_mouse_pos: Vector2

func _ready() -> void:
	Input.warp_mouse(get_viewport().get_visible_rect().size/2)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_previous_mouse_pos = get_viewport().get_visible_rect().size/2
	Input.set_custom_mouse_cursor(cursor,     Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(point_hand, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(drag,       Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(can_drop,   Input.CURSOR_CAN_DROP)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu") :
		if _options.visible :
			_options.hide()
		elif _introduction.visible :
			_introduction.hide()
		elif _dialog.visible :
			_dialog.hide()
		elif _bag.visible or _exit_auberge.visible or _exit_dungeon.visible: 
			_close()
		elif _game_over.visible :
			pass
		else :
			_bag.show()
			_menu.show()
			_show_mouse()
	if Input.is_action_just_pressed("open_bag") :
		_bag.visible = not _bag.visible
	if Input.is_action_just_pressed("open_quest") :
		$Introduction/PanelContainer/MarginContainer/VBoxContainer/TabContainer/Quete.visible = true
		_introduction.visible = not _introduction.visible
	if player.velocity.x or player.velocity.z : 
		_close()
		#pass

func update_mouse_mode() -> void:
	if (_options.visible or _bag.visible 
			or _loot.visible or _introduction.visible 
			or _dialog.visible
			or _exit_auberge.visible or _exit_dungeon.visible
			or _game_over.visible) :
		_show_mouse()
		_spells.hide()
	else :
		_hide_mouse()
		_spells.visible = not player.get_spells().is_empty()

func _show_mouse() -> void :
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Input.warp_mouse(_previous_mouse_pos)

func _hide_mouse() -> void :
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE :
		_previous_mouse_pos = get_viewport().get_mouse_position()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func openQuest()  -> void :
	_introduction.openQuest()
	_show_mouse()

func openLoot(container: Object) -> void :
	_loot.loot(container)
	_bag.show()
	_menu.show()
	_show_mouse()

func openDialog(dialog: Dialog) -> void:
	_dialog.open(dialog)
	_show_mouse()

func openAubergeExit() -> void:
	_exit_auberge.show()
	_show_mouse()

func openDungeonExit() -> void:
	_exit_dungeon.show()
	_show_mouse()

func openTransition(onMiddle : Callable, onEnd : Callable = func():pass) -> void:
	_transition.doIt(onMiddle, onEnd)

func consoleLog(text: String) -> void:
	_console.log(text)

func is_open() -> bool :
	return not $CenterCursor.visible

func can_move() -> bool :
	return not _dialog.visible and not _transition.visible and not _introduction.visible

func _close() -> void :
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE :
		_bag.hide()
		_loot.hide()
		_menu.hide()
		_introduction.hide()
		_dialog.hide()
		_options.hide()
		_exit_auberge.hide()
		_exit_dungeon.hide()
		_hide_mouse()

func _on_bag_visibility_changed() -> void:
	if not _bag.visible : 
		_loot.hide()
		_menu.hide()
	update_mouse_mode()

func _on_loot_visibility_changed() -> void:
	if not _loot.visible : 
		_bag.hide()
		update_mouse_mode()

func _on_game_over_visibility_changed() -> void:
	if _game_over.visible :
		update_mouse_mode()
