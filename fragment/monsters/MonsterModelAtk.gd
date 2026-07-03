class_name MonsterModelAtk
extends Object

var animation : String
var animation_to_hit_factor : float
var cold_down : float
var cold_down_factor : float
var _atk : int = 2
var atk_range : float = 2
var on_cold_down = false
var sound : AudioStreamPlayer3D
var _cold_down_timer : Timer = Timer.new()

func _init(json, g:Monster) -> void:
	animation = json["animation"]
	cold_down = json.get("cold_down",0)
	cold_down_factor =  json.get("cold_down_factor",0)
	atk_range = json.get("range", 2)
	animation_to_hit_factor = json.get("animation_to_hit_factor", .75)
	sound = g.get_node(json.get("sound", "Swing2"))
	_atk = json.get("atk", 2)
	
	g.add_child(_cold_down_timer)
	_cold_down_timer.one_shot = true
	_cold_down_timer.timeout.connect(self._on_cold_down_timer_timeout)

func damage() -> int:
	return Dices.d6(_atk,5)

func start() -> void:
	on_cold_down = true
	_cold_down_timer.start(cold_down)

func _on_cold_down_timer_timeout() -> void:
	on_cold_down = false
