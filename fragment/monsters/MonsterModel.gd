class_name MonsterModel
extends Object

var fov: float
var atks: Array[MonsterModelAtk] = []
var def: int
var pv: int
var global_cold_down: float

var _random = RandomNumberGenerator.new()

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

func getAtk() -> MonsterModelAtk :
	var _atk = atks[_random.randi_range(0,atks.size()-1)]
	if not _atk.on_cold_down:
		return _atk
	return null
