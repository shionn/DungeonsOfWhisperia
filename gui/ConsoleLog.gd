extends RichTextLabel

@onready var _animation = $AnimationPlayer as AnimationPlayer

func log(_text : String) -> void :
	append_text(_text)
	newline()
	_animation.stop()
	_animation.play("Hide")
