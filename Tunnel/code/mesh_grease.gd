extends MeshInstance3D


func _process(delta: float) -> void:
	for i in mesh.get_surface_count():
		if mesh.surface_get_material(i).albedo_color.a > 0.0:
			#mesh.surface_get_material(i).albedo_color.r -= delta * 1.3
			#mesh.surface_get_material(i).albedo_color.g -= delta * 1.3
			#mesh.surface_get_material(i).albedo_color.b -= delta * 1.3
			mesh.surface_get_material(i).albedo_color.a -= delta * 1.3

func _on_grease_area_entered(area: Area3D) -> void:
	for i in mesh.get_surface_count():
		#mesh.surface_get_material(i).albedo_color.r = 1.0
		#mesh.surface_get_material(i).albedo_color.g = 1.0
		#mesh.surface_get_material(i).albedo_color.b = 1.0
		mesh.surface_get_material(i).albedo_color.a = 1.0
