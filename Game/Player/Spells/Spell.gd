class_name Spell
extends GameBase

@export var icon : Resource
@export var cold_down : int
@export var aura : Node3D
# est-ce utilisé ? 
@export var duration : float

@export var animation : String
@export var animation_factor : float = .9

@export_category("Sort offensif")
@export var requier_target_monster : bool = false

signal cast()
signal cold_down_change(value : bool)
signal enable_change(valie : bool)

var _cold_down_timer : Timer = Timer.new()
var _duration_timer : Timer = Timer.new()
var _animation_timer : Timer = Timer.new()

# permet de savoir quand un sort de type aura ou buff est actif
var enable : bool = false :
	set(value):
		enable = value
		enable_change.emit(value)

var charge : int = 0 :
	set(value) : 
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
	self.add_child(_animation_timer)
	_cold_down_timer.one_shot = true
	_cold_down_timer.timeout.connect(self._on_cold_down_timer_timeout)
	_duration_timer.one_shot = true
	_duration_timer.timeout.connect(self._on_duration_timer_timeout)
	_animation_timer.one_shot = true
	_animation_timer.timeout.connect(self._on_animation_timer_timeout)
	
	
func available() -> bool :
	return not on_cold_down and (not requier_target_monster or world.target_monster and not world.target_monster.is_dead())

func start_cast() -> void :
	world.player._start_animation(animation)
	_animation_timer.start(world.player._get_animation(animation).length * animation_factor)

func _on_animation_timer_timeout() -> void :
	_cold_down_timer.start(cold_down)
	on_cold_down = true

	if aura : aura.show()
	enable = true
	if duration : _duration_timer.start(duration)
	
	cast.emit()

func get_time_left() -> int:
	return _cold_down_timer.time_left as int

func _on_cold_down_timer_timeout() -> void :
	on_cold_down = false

func _on_duration_timer_timeout() -> void :
	enable = false
