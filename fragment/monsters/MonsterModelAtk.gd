class_name MonsterModelAtk
extends Object

var animation : String
var cold_down : float
var cold_down_factor : float
var _cold_down_timer : Timer = Timer.new()
var on_cold_down = false

func _init(json, g:Monster) -> void:
	animation = json["animation"]
	cold_down = json.get("cold_down",0)
	cold_down_factor =  json.get("cold_down_factor",0)
	
	g.add_child(_cold_down_timer)
	_cold_down_timer.one_shot = true
	_cold_down_timer.timeout.connect(self._on_cold_down_timer_timeout)
	

func start() -> void:
	on_cold_down = true
	_cold_down_timer.start(cold_down)

func _on_cold_down_timer_timeout() -> void:
	
	on_cold_down = false
