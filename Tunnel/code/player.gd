extends Area3D

var is_moving:= false
var in_air:= false
var is_jumping:= false
var is_planing:= false

var aimed_repere: Node3D

@export var vitesse_lat_base:= 24.0
@export var max_vitesse_lat:= 58.4
@export var acceleration_lat:= 33.3

@onready var vitesse_lat:= vitesse_lat_base

var hauteur:= 0.0
@export var gravite:= 0.2
@export var ascension:= 0.3

@export var air_trails: Array[TunnelTrail]

@export var first_boost: Array[TunnelTrail]
@export var second_boost: Array[TunnelTrail]

@export var after_image: AfterImage

var index_anneau := 0

var position_repere:= Vector3.ZERO

var i_glide:= 0

var alive:= true

signal touche_sol

func _ready() -> void:
	aimed_repere = %GestionnaireColonnes.p_get_current_track()

func _physics_process(delta: float) -> void:
	if alive:
		if Input.is_action_just_pressed("gauche"):
			aimed_repere = %GestionnaireColonnes.p_get_last_track()
			is_moving = true
			%Deplacement.play()
			if !in_air:
				%AnimationPlayer.play("dash_sol_g")
			else:
				%AnimationPlayer.play("dash_air_g")
			
		elif Input.is_action_pressed("gauche"):
			if vitesse_lat < max_vitesse_lat:
				vitesse_lat += delta * acceleration_lat
			if !is_moving:
				aimed_repere = %GestionnaireColonnes.p_get_last_track()
				is_moving = true
				if !in_air:
					%AnimationPlayer.play("dash_sol_g")
				else:
					%AnimationPlayer.play("dash_air_g")
		elif Input.is_action_just_pressed("droite"):
			%Deplacement.play()
			aimed_repere = %GestionnaireColonnes.p_get_next_track()
			is_moving = true
			if !in_air:
				%AnimationPlayer.play("dash_sol_d")
			else:
				%AnimationPlayer.play("dash_air_d")
			
		elif Input.is_action_pressed("droite"):
			if vitesse_lat < max_vitesse_lat:
				vitesse_lat += delta * acceleration_lat
			if !is_moving:
				aimed_repere = %GestionnaireColonnes.p_get_next_track()
				is_moving = true
				if !in_air:
					%AnimationPlayer.play("dash_sol_d")
				else:
					%AnimationPlayer.play("dash_air_d")
		else:
			vitesse_lat = vitesse_lat_base
		
		if Input.is_action_just_pressed("jump") and !is_jumping and !in_air:
			%Saut.play()
			is_jumping = true
			i_glide = 1
		elif Input.is_action_pressed("jump"):
			i_glide += 1
			is_planing = true
			if !air_trails.is_empty() and hauteur >= 0.0:
				for trail in air_trails:
					trail.genere_trail = true
					trail.update_trail(delta, !is_planing)
			
				
		else:
			is_planing = false
			if !air_trails.is_empty():
				for trail in air_trails:
					trail.genere_trail = false
	
	
	if !air_trails.is_empty():
		for trail in air_trails:
			trail.update_trail(delta, !is_planing)
	
	if !first_boost.is_empty():
		for trail in first_boost:
			trail.update_trail(delta, false)
	
	if !second_boost.is_empty():
		for trail in second_boost:
			trail.update_trail(delta, false)
	
	if position_repere != aimed_repere.global_position or global_basis != aimed_repere.global_basis.orthonormalized():
		if position_repere != aimed_repere.global_position:
			position_repere = position_repere.slerp(aimed_repere.global_position, vitesse_lat * delta)
		if global_basis != aimed_repere.global_basis.orthonormalized():
			global_basis = global_basis.slerp(aimed_repere.global_basis.orthonormalized(), vitesse_lat * delta)
	
		if (position_repere - aimed_repere.global_position).length() < 0.1:
			position_repere = aimed_repere.global_position
		if global_basis.is_equal_approx(aimed_repere.global_basis.orthonormalized()):
			global_basis = aimed_repere.basis
	else:
		is_moving = false
	
	if is_jumping:
		if hauteur < 1.0:
			hauteur += ascension * delta
		else:
			is_jumping = false
			in_air = true
	
	if hauteur > 0.0:
		if !is_jumping:
			if is_planing:
				hauteur -= delta * gravite * 0.13
			else:
				hauteur -= delta * gravite
	elif in_air:
		i_glide = 0
		touche_sol.emit()
		%Sol.play()
		if !air_trails.is_empty():
				for trail in air_trails:
					trail.genere_trail = false
		in_air = false
		is_planing = false
	
	global_position = position_repere + (hauteur + 0.2) * aimed_repere.global_basis.orthonormalized().y.normalized()


func mort():
	%Mort.play()
	if %plane_mesh:
		get_tree().create_tween().tween_property(self, "hauteur", -1.5, 0.4)
		#%plane_mesh.queue_free()
	%Score._fin()
	%GestionnaireColonnes._fin()

func _on_area_entered(area: Area3D) -> void:
	var agent_met = area.get_parent()
	if agent_met is Obstacle:
		mort()
	elif agent_met is Anneau:
		%GestionnaireColonnes._on_huge_ring_passed()
		index_anneau +=1
		%Boost.play()
		if index_anneau == 1:
			for trail in first_boost:
				trail.genere_trail = true
				trail.trail_width_start = 0.23
				get_tree().create_tween().tween_property(trail, "trail_width_start", 0.05, 1.5)
		elif index_anneau == 2:
			for trail in second_boost:
				trail.trail_width_start = 0.08
				get_tree().create_tween().tween_property(trail, "trail_width_start", 0.01, 1.5)
				trail.genere_trail = true
		else:
			for trail in second_boost:
				trail.trail_width_start = 0.08
				get_tree().create_tween().tween_property(trail, "trail_width_start", 0.01, 1.5)
			for trail in first_boost:
				trail.trail_width_start = 0.23
				get_tree().create_tween().tween_property(trail, "trail_width_start", 0.05, 1.5)
				
			
	elif agent_met is AnneauBonus:
		%Score.bonus_modificateur()
