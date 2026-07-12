class_name Spell
extends Node

@export var icon : Resource
@export var cold_down : int

signal cast(spell : Spell)
signal cold_down_change(value : bool)

var _cold_down_timer : Timer = Timer.new()
var on_cold_down = false :
	set(value) :
		on_cold_down = value
		cold_down_change.emit(value)

func _init() -> void:
	self.add_child(_cold_down_timer)
	_cold_down_timer.one_shot = true
	_cold_down_timer.timeout.connect(self._on_cold_down_timer_timeout)

func activate() -> void:
	if not on_cold_down :
		cast.emit(self)
		on_cold_down = true
		_cold_down_timer.start(cold_down)
		
func _on_cold_down_timer_timeout() -> void :
	on_cold_down = false
		
