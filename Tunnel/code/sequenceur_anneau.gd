extends Node

@export var scene_seq: PackedScene

@export var beat_anneaux: Array[int]

func _ready() -> void:
	%Musique.on_beat.connect(_on_musique_on_beat)

func instanciation():
	var nv_inst:= scene_seq.instantiate()
	add_child(nv_inst)
	nv_inst.position.z = -20.0
	nv_inst.position.y = 0.0
	nv_inst.position.x = 0

func _on_musique_on_beat(beat: int) -> void:
	if scene_seq:
		if beat_anneaux.has(beat):
			instanciation()
