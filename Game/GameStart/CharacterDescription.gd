extends GridContainer

func _ready() -> void:
	hide()

func open(description : String) -> void :
	$PanelContainer/MarginContainer/RichTextLabel.clear()
	$PanelContainer/MarginContainer/RichTextLabel.append_text(description)
	show()
