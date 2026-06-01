extends MeshInstance3D
class_name PlayerGhostMesh

func _physics_process(delta: float) -> void:
	position.z += get_tree().get_first_node_in_group("GestionnaireCol").avancement_vitesse * delta
