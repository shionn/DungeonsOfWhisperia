class_name MonsterModel
extends Object

var fov: float
var atks: Array[MonsterModelAtk] = []
var def: int
var pv: int
var global_cold_down: float

var _g : Monster
var _gcdTimer : Timer = Timer.new()
var _on_gcd = false
var _random = RandomNumberGenerator.new()

#signal gcd_end()

func _init(model_file, g:Monster):
	var file = FileAccess.open(model_file, FileAccess.READ)
	var json = JSON.parse_string(file.get_as_text())
	fov = json.get("fov",60)
	def = json.get("def",1)
	pv = json.get("pv",2)
	global_cold_down = json.get("global_cold_down",2)
	for jsonAtk in json["atks"]:
		atks.append(MonsterModelAtk.new(jsonAtk, g))
	file.close()
	
	_g = g
	_gcdTimer.one_shot = true
	_gcdTimer.timeout.connect(self._on_gcd_timer_timeout)
	g.add_child(_gcdTimer)

func startAtk() -> bool:
	if _on_gcd : return false
	var atk = getAtk()
	if atk :
		atk.start()
		_g._animation.play(atk.animation)
		_g._animationTimer.start(_g._animation.get_animation(atk.animation).length)
		_gcdTimer.start(self.global_cold_down)
		_on_gcd = true
		return true
	return false


func getAtk() -> MonsterModelAtk :
	var _atk = atks[_random.randi_range(0,atks.size()-1)]
	if not _atk.on_cold_down:
		return _atk
	return null

func _on_gcd_timer_timeout() -> void:
	_on_gcd = false
	

func _on_atk_timer_timeout() -> void:
	pass
