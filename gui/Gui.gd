extends Control

@onready var cursor = load("res://assets/kenney/cursor-pack/pointer_c.png")
@onready var point_hand = load("res://assets/kenney/cursor-pack/hand_small_point.png")
@onready var drag = load("res://assets/kenney/cursor-pack/hand_closed.png")
@onready var can_drop = load("res://assets/kenney/cursor-pack/hand_open.png")

func _ready() -> void:
	Input.warp_mouse(get_viewport().get_visible_rect().size/2)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(point_hand, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(drag, Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(can_drop, Input.CURSOR_CAN_DROP)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu") :
		if $Bag.visible : 
			_close()
		else :
			_open()

func openLoot(monster: Monster) -> void :
	$Loot.loot(monster)
	_open()

func _open() -> void : 
	$Bag.visible = true
	$Menu.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _close() -> void :
	$Bag.visible = false
	$Loot.visible = false
	$Menu.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
