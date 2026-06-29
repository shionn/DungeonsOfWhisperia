extends RichTextLabel

@onready var _animation = $AnimationPlayer as AnimationPlayer

func log(_text : String) -> void :
	append_text(_text)
	_animation.play("Hide")
