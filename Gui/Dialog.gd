class_name Dialog
extends Node

@export_multiline var text: String
@export var label: String:
	get():
		return name as String if label.is_empty() else label
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

func enabled_options() -> Array[Dialog]:
	return options.filter(func (o):return o.enable)
