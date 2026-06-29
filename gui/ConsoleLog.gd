extends RichTextLabel

@onready var _animation = $AnimationPlayer as AnimationPlayer

func log(_text : String) -> void :
	append_text(_text)
	newline()
	_animation.play("Hide")
