extends ColorRect

class_name Transition

@onready var _anim = $AnimationPlayer
var _callback : Callable

func doIt(onMiddle : Callable) -> void:
	_callback = onMiddle
	visible = true
	_anim.play("fade_in")

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in" :
		_callback.call()
		_anim.play("fade_out")
	elif anim_name == "fade_out" :
		visible = false
