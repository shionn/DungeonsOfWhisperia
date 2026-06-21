extends Control

@onready var cursor = load("res://assets/kenney/cursor-pack/pointer_c.png")
@onready var point_hand = load("res://assets/kenney/cursor-pack/hand_small_point.png")
@onready var drag = load("res://assets/kenney/cursor-pack/hand_closed.png")
@onready var can_drop = load("res://assets/kenney/cursor-pack/hand_open.png")

@onready var _bag = $Bag

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(point_hand, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(drag, Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(can_drop, Input.CURSOR_CAN_DROP)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu") :
		if _bag.visible : 
			_bag.visible = false
			$Loot.visible = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else :
			_bag.visible = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
