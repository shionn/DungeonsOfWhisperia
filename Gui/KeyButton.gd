extends Button

@onready var options := $/root/World/Options as Options

@export var action_name : String

var _capture : bool = false

func _ready() -> void:
	_on_applied()

func _on_pressed() -> void:
	_capture = true
	text = "..."
	options.applied.connect(_on_applied)

func _unhandled_key_input(event: InputEvent) -> void:
	if _capture and event is InputEventKey :
		var e = event as InputEventKey
		text = e.as_text_key_label()
		_capture = false
		options.set_input_key(action_name, e.keycode)
		options.apply_and_save()

func _on_applied() -> void:
	text = OS.get_keycode_string(options.get_input_key(action_name, KEY_0))
	
