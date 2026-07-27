class_name MonsterAtk
extends Node

@export var animation : String
@export var cold_down : float
@export var atk_range : float = 2
@export var sound : AudioStreamPlayer3D

@export_category("Main Handed")
@export var animation_to_hit_factor : float
@export var atk_dice : int = 2
@export var atk_dice_lvl_factor : float = 1

@export_category("Dual Handed")
@export var dual_hand : bool = false
@export var off_hand_animation_to_hit_factor : float
@export var off_hand_atk_dice : int = 2

var _cold_down_timer : Timer = Timer.new()
var on_cold_down = false

func _init() -> void:
	self.add_child(_cold_down_timer)
	_cold_down_timer.one_shot = true
	_cold_down_timer.timeout.connect(self._on_cold_down_timer_timeout)

func damage() -> int:
	return Dices.d6(atk_dice + floori(_monster().lvl*atk_dice_lvl_factor),5)

func off_hand_damage() -> int:
	return Dices.d6(off_hand_atk_dice,5)

func start() -> void:
	on_cold_down = true
	_cold_down_timer.start(cold_down)

func _on_cold_down_timer_timeout() -> void:
	on_cold_down = false
	
func _monster() -> Monster :
	return get_parent() as Monster
