class_name MonsterModelAtk
extends Object

var animation : String
var hit_factor : float
var cold_down : float
var cold_down_factor : float
var _atk : int = 2
var atk_range : float = 2
var on_cold_down = false
var _cold_down_timer : Timer = Timer.new()

func _init(json, g:Monster) -> void:
	animation = json["animation"]
	cold_down = json.get("cold_down",0)
	cold_down_factor =  json.get("cold_down_factor",0)
	atk_range = json.get("range", 2)
	hit_factor = json.get("hit_factor", 1)
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
