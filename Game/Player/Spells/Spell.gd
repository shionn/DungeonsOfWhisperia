class_name Spell
extends Node

@export var icon : Resource
@export var cold_down : int
@export var animation : String
@export var aura : Node3D
@export var duration : float

signal cast()
signal cold_down_change(value : bool)
signal enable_change(valie : bool)

var _cold_down_timer : Timer = Timer.new()
var _duration_timer : Timer = Timer.new()

var enable : bool = false :
	set(value):
		enable = value
		enable_change.emit(value)
		
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
	self.add_child(_duration_timer)
	_cold_down_timer.one_shot = true
	_cold_down_timer.timeout.connect(self._on_cold_down_timer_timeout)
	_duration_timer.one_shot = true
	_duration_timer.timeout.connect(self._on_duration_timer_timeout)

func activate() -> void:
	_cold_down_timer.start(cold_down)
	if aura : aura.show()
	cast.emit()
	if duration : _duration_timer.start(duration)
	enable = true
	on_cold_down = true

func get_time_left() -> int:
	return _cold_down_timer.time_left as int
		
func _on_cold_down_timer_timeout() -> void :
	on_cold_down = false

func _on_duration_timer_timeout() -> void :
	enable = false
