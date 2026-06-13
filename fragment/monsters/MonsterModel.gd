class_name MonsterModel
extends Object

var fov: float
var atks: Array[MonsterModelAtk]

func _init(model_file):
	var file = FileAccess.open(model_file, FileAccess.READ)
	var json = JSON.parse_string(file.get_as_text())
	fov = json["fov"]
	file.close()
