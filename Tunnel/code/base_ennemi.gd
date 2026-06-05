extends Node3D
class_name Obstacle


@export var latence:= 3.0

@export var meshes : Array[MeshInstance3D]

@export var vitesse:= 0.0

@onready var gestionnaire_colonnes:= get_tree().get_first_node_in_group("GestionnaireCol")

@export var alpha := 0.2

var i_colonne:= 0

func _ready() -> void:
	if alpha  != 1.0:
		for mesh in meshes:
			if mesh:
				if mesh.mesh is ArrayMesh:
					for i in mesh.mesh.get_surface_count():
						var mat = mesh.mesh.surface_get_material(i).duplicate()
						if mat is StandardMaterial3D:
							#mat.albedo_color.a = alpha 
							mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_HASH
						mesh.mesh.surface_set_material(i, mat)

func _physics_process(delta: float) -> void:
	position.z += (gestionnaire_colonnes.avancement_vitesse + vitesse) * delta
			
	if position.z > latence:
		var score = get_tree().get_first_node_in_group("Score")
		score.score += 0.1 * score.modificateur
		queue_free()
