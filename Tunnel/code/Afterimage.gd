extends Node3D	
class_name AfterImage


@export var frames_between_ghosts: int = 5     
@export var ghost_lifetime: float = 2.0         
@export var gradient: Gradient                 
@export var prog_couleur:= 1.0
var index_couleur = 0.0

@export var meshes: Array[MeshInstance3D]


@export var player:= false

var frame_counter: int = 0


# Dictionnaire : {node, age_actuel, durée_vie}
var active_ghosts: Array[Dictionary] = []

var ghost_shader: Shader

func _ready():
	ghost_shader = load("res://Tunnel/assets/shader/ghost_trail.gdshader")

func _process(delta: float):
	index_couleur += delta * prog_couleur
	if index_couleur >= 1.0:
		index_couleur -= 1.0
	frame_counter += 1
	
			
	
	#position -= delta * 2.0 * %Camera3D.global_basis.z
	# --- Spawn d'un nouveau ghost ---
	if frame_counter >= frames_between_ghosts and !meshes.is_empty():
		for i in range(meshes.size()):
			if i < meshes.size():
				if !meshes[i]:
					meshes.remove_at(i)
		frame_counter = 0
		for mesh in meshes:
			if mesh:
				_spawn_ghost(mesh)

	#for

	# --- Mise à jour des ghosts existants ---
	
	for i in range(active_ghosts.size() - 1, -1, -1):
		var ghost_data = active_ghosts[i]
		ghost_data["age"] += delta

		var age = ghost_data["age"]
		var lifetime = ghost_data["lifetime"]

		if age >= lifetime:
			# Ghost trop vieux : on le supprime
			ghost_data["node"].queue_free()
			active_ghosts.remove_at(i)

func _spawn_ghost(mesh: MeshInstance3D):
	var ghost
	if player:
		ghost = PlayerGhostMesh.new()
	else:
		ghost = GhostMesh.new()
	ghost.mesh = mesh.mesh 


	var mat = ShaderMaterial.new()
	mat.shader = ghost_shader
	var color: Color = gradient.sample(index_couleur)
	mat.set_shader_parameter("ghost_color", color)
	ghost.material_override = mat

	add_child(ghost)

	ghost.global_transform = mesh.global_transform
	
	active_ghosts.append({
		"node": ghost,
		"material": mat,
		"age": 0.0,
		"lifetime": ghost_lifetime,
		"gradient_position": index_couleur
	})

	_recalculate_gradient_positions()

func _recalculate_gradient_positions():
	var count = active_ghosts.size()
	if count == 0:
		return

	for i in range(count):
		active_ghosts[i]["gradient_position"] = float(count - 1 - i) / float(count)
