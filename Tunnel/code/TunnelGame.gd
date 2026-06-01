extends Node3D


func _ready():
	RenderingServer.set_debug_generate_wireframes(true)
	get_viewport().debug_draw = get_viewport().DEBUG_DRAW_WIREFRAME

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("quit"):
		get_tree().quit()
