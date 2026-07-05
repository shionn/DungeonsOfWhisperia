class_name MonsterAtk
extends Node

@export var animation : String
@export var animation_to_hit_factor : float
@export var cold_down : float
@export var atk_dice : int = 2
@export var atk_range : float = 2
@export var sound : AudioStreamPlayer3D

var _cold_down_timer : Timer = Timer.new()
var on_cold_down = false

func _init() -> void:
	self.add_child(_cold_down_timer)
	_cold_down_timer.one_shot = true
	_cold_down_timer.timeout.connect(self._on_cold_down_timer_timeout)

func damage() -> int:
	return Dices.d6(atk_dice,5)

func start() -> void:
	on_cold_down = true
	_cold_down_timer.start(cold_down)

func _on_cold_down_timer_timeout() -> void:
	on_cold_down = false
