extends Node

@export var scene_seq: PackedScene
@export var scene_haut: PackedScene

@export var array_sequences: Array[Dictionary]

#@export var sequence: Sequence

@export var after_image_haut: AfterImage
@export var after_image_bas: AfterImage

@export var starting_beats:Array[int]=[0]
@export var ending_beats:Array[int]=[]


var playing:= false

var index_start:= 0

func _ready() -> void:
	%Musique.on_beat.connect(_on_musique_on_beat)

func valeurToCreation(valeur: int):
	var colonnes_concernees:= []
	
	# Truc automatique pour quand la vitesse augmente
	if abs(valeur) >= 1000:
		if valeur > 0:
			valeur -= 1000
		else:
			valeur += 1000
	
	# Pour mettre en hauteur, ajouter 200 à la valeur ciblée (selon les critères en dessous)
	var mod_hauteur = 0.0
	if abs(valeur) >= 200 and valeur!= 444:
		mod_hauteur = 0.8
		if valeur > 0:
			valeur -= 200
		else:
			valeur += 200
			
	# Pour placer un tour complet d'iles, mettre 444
	if valeur == 444:
		for colonne in %GestionnaireColonnes.colonnes:
			colonnes_concernees.append(colonne)
			instanciation(colonne, mod_hauteur)
			
			
	# Pour placer plusieurs iles autour sur une colonne et celles adjacentes mettre une certaine vingtaine 
	# (180: 9 adjacentes de chaque cote,  160:8,  140:7,  120:6, 100:5, etc...)
	# L'unité/dizaine supp après c'est pour dire de quelle colonne partir (au centre du coup)
	# ex : 86 c'est 4 iles de chaque cote autour de la colonne 6
	# 96 c'est 4 iles de chaque coté autour de la colonne 16 (si elle existe)
	elif abs(valeur) < 200:
		if abs(valeur) >= 180:
			if valeur < 0:
				valeur += 180
			else:
				valeur -= 180
			for colonne in %GestionnaireColonnes.get_range_from_center(abs(valeur), 9):
				colonnes_concernees.append(colonne)
		elif abs(valeur) >= 160:
			if valeur < 0:
				valeur += 160
			else:
				valeur -= 160
			for colonne in %GestionnaireColonnes.get_range_from_center(abs(valeur), 8):
				colonnes_concernees.append(colonne)
		elif abs(valeur) >= 140:
			if valeur < 0:
				valeur += 140
			else:
				valeur -= 140
			for colonne in %GestionnaireColonnes.get_range_from_center(abs(valeur), 7):
				colonnes_concernees.append(colonne)
		elif abs(valeur) >= 120:
			if valeur < 0:
				valeur += 120
			else:
				valeur -= 120
			for colonne in %GestionnaireColonnes.get_range_from_center(abs(valeur), 6):
				colonnes_concernees.append(colonne)
		elif abs(valeur) >= 100:
			if valeur < 0:
				valeur += 100
			else:
				valeur -= 100
			for colonne in %GestionnaireColonnes.get_range_from_center(abs(valeur), 5):
				colonnes_concernees.append(colonne)
		elif abs(valeur) >= 80:
			if valeur < 0:
				valeur += 80
			else:
				valeur -= 80
			for colonne in %GestionnaireColonnes.get_range_from_center(abs(valeur), 4):
				colonnes_concernees.append(colonne)
		elif abs(valeur) >= 60:
			if valeur < 0:
				valeur += 60
			else:
				valeur -= 60
			for colonne in %GestionnaireColonnes.get_range_from_center(abs(valeur), 3):
				colonnes_concernees.append(colonne)
		elif abs(valeur) >= 40:
			if valeur < 0:
				valeur += 40
			else:
				valeur -= 40
			for colonne in %GestionnaireColonnes.get_range_from_center(abs(valeur), 2):
				colonnes_concernees.append(colonne)
		elif abs(valeur) >= 20:
			if valeur < 0:
				valeur += 20
			else:
				valeur -= 20
			for colonne in %GestionnaireColonnes.get_range_from_center(abs(valeur), 1):
				colonnes_concernees.append(colonne)
		else:
			colonnes_concernees.append(%GestionnaireColonnes.colonnes[abs(valeur)])
	
	
	# Mettre en négatif fait apparaitre inversement sur les autres colonnes que celles selectionnées
	if valeur < 0:
		for colonne in %GestionnaireColonnes.colonnes:
			if !colonnes_concernees.has(colonne):
				colonnes_concernees.append(colonne)
				instanciation(colonne, mod_hauteur)
	else:
		for colonne in colonnes_concernees:
			instanciation(colonne, mod_hauteur)

func instanciation(colonne: Node3D, mod_hauteur:= 0.0):
	var nv_inst
	if mod_hauteur != 0.0 and scene_haut:
		nv_inst = scene_haut.instantiate()
	else:
		nv_inst = scene_seq.instantiate()
	colonne.add_child(nv_inst)
	nv_inst.position.z = -13.0
	nv_inst.position.y += mod_hauteur + 0.1
	
	if after_image_haut and mod_hauteur != 0.0:
		for mesh in nv_inst.meshes:
			after_image_haut.meshes.append(mesh)
	elif after_image_bas:
		for mesh in nv_inst.meshes:
			after_image_bas.meshes.append(mesh)

func _on_musique_on_beat(beat: int) -> void:
	for i in starting_beats:
		if beat == i:
			index_start = i
			playing = true
	for i in ending_beats:
		if beat == i:
			playing = false
	if beat >= index_start and playing:
		beat -= index_start
		if scene_seq:
			for matrice in array_sequences:
				if matrice.has(beat):
					
					if matrice.get(beat) is int:
						valeurToCreation(matrice.get(beat))
						if get_tree().get_first_node_in_group("GestionnaireCol").avancement_vitesse >= 4.0:
							for i in range(int(get_tree().get_first_node_in_group("GestionnaireCol").avancement_vitesse / 2) - 1):
								if matrice.get(beat) >= 0 and matrice.get(beat) < 200:
									if matrice.get(beat+i+1) is int:
										matrice.set(beat+i+1, [matrice.get(beat+i+1), matrice.get(beat)+ 1000])
									elif matrice.get(beat+i+1) is Array or matrice.get(beat+i+1) is PackedInt64Array:
										matrice.get(beat+i+1).append(matrice.get(beat)+ 1000)
									else:
										matrice.set(beat+i+1, matrice.get(beat) + 1000)
						
					elif matrice.get(beat) is Array  or matrice.get(beat) is PackedInt64Array:
						for called in matrice.get(beat):
							valeurToCreation(called)
							if get_tree().get_first_node_in_group("GestionnaireCol").avancement_vitesse >= 4.0:
								for i in range(int(get_tree().get_first_node_in_group("GestionnaireCol").avancement_vitesse / 2) - 1):
									if called >= 0 and called < 200:
										if matrice.get(beat+i+1) is int:
											matrice.set(beat+i+1, [matrice.get(beat+i+1), called+ 1000])
										elif matrice.get(beat+i+1) is Array:
											matrice.get(beat+i+1).append(called+ 1000)
										else:
											matrice.set(beat+i+1, called + 1000)
