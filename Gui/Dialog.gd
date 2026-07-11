class_name Dialog
extends Node

@export_multiline var text: String
@export var pnj: PNJ = null

var next : Dialog
signal close()

func _ready() -> void:
	next = get_node_or_null("Next")
