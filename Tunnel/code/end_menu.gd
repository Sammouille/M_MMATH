extends Control

@export var restart_button: Button

func _restart():
	get_tree().reload_current_scene()
