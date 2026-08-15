class_name LightSign
extends Interactable

@export var enable_end = false
@export var length1 : float = 4
@export var length2 : float = 4
@export var target_angle : float = 0
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


func _on_activate() -> void:
	rotate_y(deg_to_rad(90))
	print("%f,%f"%[rad_to_deg(rotation.y),target_angle])
	var v = is_equal_approx( rad_to_deg(rotation.y), target_angle)
	if _laser1 : _laser1.visible = v
	if _laser2 : _laser2.visible = v
	
			
	pass # Replace with function body.

func is_good() -> bool:
	print("%f,%f"%[rad_to_deg(rotation.y),target_angle])
	return is_emiting() and is_equal_approx( rad_to_deg(rotation.y), target_angle)

func is_emiting() -> bool:
	return previous == null or previous.is_good()
