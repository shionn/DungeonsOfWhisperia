extends Node3D

@export var _anim = "Melee_1H_Attack_Slice_Diagonal"
@export_multiline var _description: String

signal select(model:String)

func _ready() -> void:
	$Area3D.connect("mouse_entered",_mouse_entered)
	$Area3D.connect("mouse_exited",_mouse_exit)
	$Area3D.connect("input_event",_on_input_event)
	$AnimationPlayer.play("RigMedium/Idle_A")
	
func _mouse_entered() -> void :
	$AnimationPlayer.play("RigMedium/"+_anim)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _mouse_exit() -> void :
	$AnimationPlayer.play("RigMedium/Idle_A")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and Input.is_action_just_pressed("interact"): 
		select.emit(name)
