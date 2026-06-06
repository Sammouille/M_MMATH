extends Node3D


func _ready():
	RenderingServer.set_debug_generate_wireframes(true)
	get_viewport().debug_draw = get_viewport().DEBUG_DRAW_WIREFRAME
