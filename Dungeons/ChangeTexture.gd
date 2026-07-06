extends Node3D

@export var _enable : bool = true
@export var _texture : Texture2D

func _ready() -> void:
	if _enable : apply_to_node(self)

func apply_to_node(elem :Node3D) -> void :
	for child in elem.get_children() :
		if child is MeshInstance3D :
			var mesh = child as MeshInstance3D
			var i = 0
			var mat = mesh.get_active_material(i) as StandardMaterial3D
			while mat != null :
				mat.albedo_texture = _texture
				i = i+1
				mat = mesh.get_active_material(i) as StandardMaterial3D
		elif child is Node3D :
			apply_to_node(child)
