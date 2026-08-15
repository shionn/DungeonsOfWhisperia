class_name LightSign
extends Interactable

@export var enable_end = false
@export var length1 : float = 4
@export var length2 : float = 4
@export var angle : int = 0
@export var target_angle : int = 0
@export var previous : LightSign = null

var _laser1 : VFX_Beam = null
var _laser2 : VFX_Beam = null

func _ready() -> void:
	super._ready()
	_laser1 = get_node_or_null("Laser1")
	_laser2 = get_node_or_null("Laser2")
	if _laser1 : 
		_laser1.beam_length = length1
		_laser1.enable_end = enable_end
	if _laser2 : 
		_laser2.beam_length = length1
		_laser2.enable_end = enable_end
	rotation.y = deg_to_rad(angle*90)


func _on_activate() -> void:
	angle = angle + 1
	if angle >= 4: angle = angle -4
	rotation.y = deg_to_rad(angle*90)
	get_parent().updade_lights()

func updade_light() -> void:
	if previous : previous.updade_light()
	var v = is_emiting()
	if _laser1 : _laser1.visible = v
	if _laser2 : _laser2.visible = v

func is_good() -> bool:
	if _laser2 :
		return is_emiting() and angle%2 == target_angle%2
	return is_emiting() and angle == target_angle

func is_emiting() -> bool:
	return previous == null or previous.is_good()
