extends Node3D

@export var colonnes: Array[Node3D]

@export var tubique:= true

@export var index_player:= 6

@export var liste_vitesses: Array[float]

var index_anneau:= 0

@onready var avancement_vitesse:= liste_vitesses[0]

signal deplacement_colonne(i_colonne: int)

func p_get_current_track():
	return colonnes[index_player]

func p_get_next_track():
	if index_player >= colonnes.size()-1:
		if tubique:
			index_player = 0
	else:
		index_player += 1
	deplacement_colonne.emit(index_player)
	return colonnes[index_player]

func p_get_last_track():
	if index_player <= 0:
		if tubique:
			index_player = colonnes.size()-1
	else:
		index_player -= 1
	deplacement_colonne.emit(index_player)
	return colonnes[index_player]

func get_range_from_center(center: int, _range: int):
	if center >= colonnes.size():
		return []
	var tracks_selected = []
	tracks_selected.append(colonnes[center])
	for i in range(_range):
		if i+1+center >= colonnes.size():
			tracks_selected.append(colonnes[center+1+i-colonnes.size()])
		else:
			tracks_selected.append(colonnes[center+i+1])
		tracks_selected.append(colonnes[center-1-i])
	return tracks_selected

func _on_huge_ring_passed():
	index_anneau += 1
	%Prompter.afficher_texte()
	%Score._on_huge_ring_passed()
	get_tree().create_tween().tween_property(self, "avancement_vitesse", liste_vitesses[index_anneau], 2.5)
	get_tree().create_tween().tween_property(%Camera3D, "fov", %Camera3D.fov + 5.0, 0.5)
	get_tree().create_tween().tween_property(%Camera3D, "position.z", %Camera3D.position.z - 0.2, 0.5)

func _fin():
	get_tree().create_tween().tween_property(%Musique,"pitch_scale", 0.0, 1.4)
	await get_tree().create_tween().tween_property(self,"avancement_vitesse", 0.0, 1.4).finished
	%Musique.stop()
