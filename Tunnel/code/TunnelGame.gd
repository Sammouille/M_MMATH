extends Node3D

const SAVE_CONFIG_PATH := "user://saveconfig.tres"

var config_handler:= ConfigHandler.new()

func _ready():
	RenderingServer.set_debug_generate_wireframes(true)
	get_viewport().debug_draw = get_viewport().DEBUG_DRAW_WIREFRAME
	config_handler.load_all()
	config_handler.apply_config()
	
