extends ColorRect

class_name Transition

@onready var _anim = $AnimationPlayer
var _callback_on_middle : Callable
var _callback_on_end : Callable

func doIt(onMiddle : Callable,onEnd : Callable = func():pass) -> void:
	_callback_on_middle = onMiddle
	_callback_on_end = onEnd
	visible = true
	_anim.play("fade_in")

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in" :
		_callback_on_middle.call()
		_anim.play("fade_out")
	elif anim_name == "fade_out" :
		_callback_on_end.call()
		visible = false
