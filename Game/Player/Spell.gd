class_name Spell
extends Node

@export var icon : Resource
@export var cold_down : int
@export var animation : String
@export var aura : Node3D

signal cast()
signal cold_down_change(value : bool)

var _cold_down_timer : Timer = Timer.new()

var enable : bool = false
var charge : int = 0 :
	set(value) : 
		print(value)
		charge = value
		if charge == 0 :
			enable = false
			if aura : aura.hide()
	

var on_cold_down = false :
	set(value) :
		on_cold_down = value
		cold_down_change.emit(value)

func _init() -> void:
	self.add_child(_cold_down_timer)
	_cold_down_timer.one_shot = true
	_cold_down_timer.timeout.connect(self._on_cold_down_timer_timeout)

func activate() -> void:
	_cold_down_timer.start(cold_down)
	if aura : aura.show()
	cast.emit()
	on_cold_down = true

func get_time_left() -> int:
	return _cold_down_timer.time_left as int
		
func _on_cold_down_timer_timeout() -> void :
	on_cold_down = false
		
