extends Node3D
class_name AnneauBonus

@onready var gestionnaire_colonnes:= get_tree().get_first_node_in_group("GestionnaireCol")

@export var meshes: Array[MeshInstance3D]


func _physics_process(delta: float) -> void:
	position.z += gestionnaire_colonnes.avancement_vitesse * delta



func _on_anneau_area_entered(area: Area3D) -> void:
	for mesh in meshes:
		if mesh.mesh.surface_get_material(0) is StandardMaterial3D:
			mesh.mesh = mesh.mesh.duplicate()
			var mat = mesh.mesh.surface_get_material(0).duplicate()
			mat.albedo_color.a = 0.4
			mesh.mesh.surface_set_material(0, mat)
	$AudioStreamPlayer3D.play()
