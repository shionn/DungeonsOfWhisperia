extends Node3D

func _ready() -> void:
	for child in self.get_children() :
		if child is MeshInstance3D :
			var mesh = child as MeshInstance3D
			var i = 0
			var mat = mesh.get_active_material(i) as StandardMaterial3D
			while mat != null :
				print(mat.albedo_texture)
				i = i+1
				mat = mesh.get_active_material(i) as StandardMaterial3D
