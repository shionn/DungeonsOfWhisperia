class_name FlipTokenSwitch
extends Interactable

@onready var black = $checker_black_single
@onready var white = $checker_white_single
@export var state: bool = false

signal state_change(token: FlipTokenSwitch)

var initial_state: bool

func _ready() -> void:
	white.visible = state
	black.visible = not state
	initial_state = state
	super._ready()

func toggle() -> void : 
	state = not state
	white.visible = state
	black.visible = not state

func reset() -> void :
	state = initial_state
	white.visible = state
	black.visible = not state

func _on_activate() -> void:
	toggle()
	state_change.emit(self)
