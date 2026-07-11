extends Control

@export var restart_button: Button

@export var scene_keyb: PackedScene
@export var scene_cont: PackedScene

func _restart():
	if %StartMenu.keyboard:
		get_tree().change_scene_to_packed(scene_keyb)
	else:
		get_tree().change_scene_to_packed(scene_cont)
