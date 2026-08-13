extends Node3D

@onready var _cog1 = $Parts_Axes1/Cog
@onready var _cog2 = $Parts_Axes2/Cog
@onready var _cog3 = $Parts_Axes3/Cog
@onready var _cog4 = $Parts_Axes4/Cog
@onready var _light = $Parts_Axes4/Topaz/LootVFX_Legendary as VFXLoot

var _rotating = false 

func _ready() -> void:
	
	pass
	
func _physics_process(delta: float) -> void:
	if _rotating :
		_cog1.rotate_x(delta)
		_cog2.rotate_x(-delta*6/10)
		if _cog2.visible :
			_cog3.rotate_x(delta)
			if _cog3.visible :
				_cog4.rotate_x(-delta*6/10)


func _on_switch_state_change(state: bool) -> void:
	_rotating = state
	if not _rotating :
		_cog1.rotation.x = 0
		_cog2.rotation.x = 0
		_cog3.rotation.x = 0
		_cog4.rotation.x = 0
	_light.visible = _cog2.visible and _cog3.visible and state
