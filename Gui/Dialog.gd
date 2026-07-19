class_name Dialog
extends Node

@export_multiline var text: String
@export var pnj: GameBaseCharacterBody3D = null
@export var enable:bool = true
@export var close_enable = true

var next : Dialog
var options : Array[Dialog] = []
signal close()
signal activate()

func _ready() -> void:
	next = get_node_or_null("Next")
	for child in get_children() :
		if child is Dialog and child.name != "Next" :
			options.append(child)
