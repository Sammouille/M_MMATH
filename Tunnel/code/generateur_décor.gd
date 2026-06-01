extends Node

@export var scene_seq: PackedScene
@export var bruit_generation: Noise

var index_gen:= 0.0
@export var pas_gen:= 100.0

var index_beat:= 0

@export var array_sequences: Array[Dictionary]

func _ready() -> void:
	%Musique.on_beat.connect(_on_musique_on_beat)

func instanciation(colonne: Node3D, mod_hauteur:= 0.0, _scale:= Vector3(0.05,0.05,0.05), rotation:= Vector3.ZERO):
	var nv_inst:= scene_seq.instantiate()
	nv_inst.alpha = 0.3
	colonne.add_child(nv_inst)
	nv_inst.position.z = -20.0
	nv_inst.position.y += mod_hauteur
	nv_inst.scale = _scale
	if rotation != Vector3.ZERO:
		nv_inst.rotation = rotation

func _on_musique_on_beat(beat: int) -> void:
	index_beat += 1
	if index_beat >= 3:
		index_beat = 0
		index_gen += pas_gen
		var hauteur:= -0.6 - (bruit_generation.get_noise_1d(index_gen) + 1.0) * 5.0
		var track:= randi_range(0, 11)
		var _scale:= Vector3(0.05,0.05,0.05) * (bruit_generation.get_noise_3d(0.0,0.0, index_gen) + 1.0) * 5.0
		
		instanciation(%GestionnaireColonnes.colonnes[track], hauteur, _scale)
	
	
	for matrice in array_sequences:
		if matrice.has(beat):
			
			if matrice.get(beat) is int:
				valeurToCreation(matrice.get(beat))
			elif matrice.get(beat) is Array:
				for called in matrice.get(beat):
					valeurToCreation(called)
	

func valeurToCreation(valeur: int):
	var mod_hauteur = 0.0
	if abs(valeur) >= 100:
		mod_hauteur = 0.8
		if valeur > 0:
			valeur -= 100
		else:
			valeur += 100
	if valeur == 44:
		for colonne in %GestionnaireColonnes.colonnes:
				instanciation(colonne, mod_hauteur+ 0.3, Vector3(0.5,0.5,0.5))
	elif valeur == 13:
		for colonne in %GestionnaireColonnes.colonnes:
				instanciation(colonne, mod_hauteur -7.0, Vector3(0.5,0.5,0.5), Vector3(1.0,0.0,5.0).normalized())
	elif valeur < 0:
		for colonne in %GestionnaireColonnes.colonnes:
			if abs(valeur) != %GestionnaireColonnes.colonnes.find(colonne, mod_hauteur):
				instanciation(colonne, mod_hauteur)
	else:
		
		instanciation(%GestionnaireColonnes.colonnes[valeur], mod_hauteur)
