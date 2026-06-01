extends Node3D

@export var vitesse:= 0.4

@export var player: Node3D

func _process(delta: float) -> void:
	if global_position != %GestionnaireColonnes.p_get_current_track().global_position:
		global_position = global_position.lerp(%GestionnaireColonnes.p_get_current_track().global_position, vitesse)
	if global_basis != %GestionnaireColonnes.p_get_current_track().global_basis:
		global_basis = global_basis.slerp(%GestionnaireColonnes.p_get_current_track().global_basis, vitesse)
