extends MeshInstance3D

var shield_actif:= false

func _process(delta: float) -> void:
	for i in mesh.get_surface_count():
		if shield_actif:
			if mesh.surface_get_material(i).albedo_color.a < 1.0:
				mesh.surface_get_material(i).albedo_color.a += delta * 1.3
		
		elif mesh.surface_get_material(i).albedo_color.a > 0.0:
			mesh.surface_get_material(i).albedo_color.a -= delta * 1.2
