extends MeshInstance3D

func _process(delta: float) -> void:
	if mesh.material.albedo_color.r > 0.0:
		mesh.material.albedo_color.r -= delta * 2.0
		mesh.material.albedo_color.g -= delta * 2.0
		mesh.material.albedo_color.b -= delta * 2.0

func _on_grease_area_entered(area: Area3D) -> void:
	mesh.material.albedo_color.r = 1.0
	mesh.material.albedo_color.g = 1.0
	mesh.material.albedo_color.b = 1.0
