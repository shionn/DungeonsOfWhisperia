extends Node3D
class_name Interactable

enum Action { ACTIVATE, LOOK }

@onready var _area := $Area3D as Area3D

@export var action : Action = Action.ACTIVATE
@export_multiline var description : String

func _ready() -> void:
	_area.connect("mouse_entered", _on_mouse_entered)
	_area.connect("mouse_exited", _on_mouse_exited)
	_area.connect("input_event", _on_input_event)

func on_interact() -> void: 
	#if description :
		
	print("on_interact is not overwrite")


func _on_mouse_entered() -> void:
	print ("_on_mouse_entered")
	# deposer un objet
	# changer l'icone ? 
	pass
#	if bag and bag.drag != null:
#		bag.drag.on_enter(self)
#	else : 
#		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited() -> void:
	print ("_on_mouse_exited")
	pass
#	if bag and bag.drag != null:
#		bag.drag.on_exit(self)
#	else :
#		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and Input.is_action_just_pressed("interact"): 
#		if player :
#			if player.global_position.distance_to(self.global_position) < interactable_distance :
#				#player.play_anim_interact()
#				on_interact()
#			else :
#				player.play_anim_no()
#				gui.append_to_console("Trop loin")
#		else :
			on_interact()
