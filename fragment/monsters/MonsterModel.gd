class_name MonsterModel
extends Object

var fov: float
var atks: Array[MonsterModelAtk] = []
var def: int
var pv: int
var chase_distance : float
var min_atk_range : float = 100
var global_cold_down: float
var large: bool
var rig: String

var _random = RandomNumberGenerator.new()

func _init(model_file, g:Monster):
	var file = FileAccess.open(model_file, FileAccess.READ)
	var json = JSON.parse_string(file.get_as_text())
	fov = json.get("fov",140)
	def = json.get("def",1)
	pv = json.get("pv",2)
	large = json.get("large", false)
	rig = "RigLarge/" if large else "RigMedium/"
	chase_distance = json.get("chase_distance", 1.5)
	global_cold_down = json.get("global_cold_down",2)
	for jsonAtk in json["atks"]:
		var atk = MonsterModelAtk.new(jsonAtk, g)
		atks.append(atk)
		if atk.atk_range < min_atk_range :
			min_atk_range = atk.atk_range
	file.close()
	
	

func get_atk() -> MonsterModelAtk :
	var _atk = atks[_random.randi_range(0,atks.size()-1)]
	if not _atk.on_cold_down:
		return _atk
	return null
