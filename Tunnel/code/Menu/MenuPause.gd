extends Control
class_name MenuPause

# Est ce que le menu met le jeu en pause
@export var fait_pause = true

var actif:= false

var ancien_mouse_mode

var main 

@onready var menu_central = find_child("MenuCentral")
@onready var bt_sauvegarder: Button = find_child("Sauvegarder")

@export var scene_options : PackedScene
var inst_options

@onready var anim_player : AnimationPlayer = $AnimationPlayer

func ouvrir():
	actif = true
	show()
	if fait_pause :
		get_tree().get_first_node_in_group("musique").stream_paused = true
		pause()
	
	
	anim_player.play("blur_on")
	
	await anim_player.animation_finished
	
	if Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
		ancien_mouse_mode = Input.mouse_mode
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	%Continuer.grab_focus()


func continuer():
	if inst_options:
		inst_options.turning_off()
	
	actif = false
	
	
	
	if ancien_mouse_mode != null:
		Input.mouse_mode = ancien_mouse_mode
		ancien_mouse_mode = null
	
	anim_player.play("blur_off")
	
	get_tree().get_first_node_in_group("musique").stream_paused = false
	
	await anim_player.animation_finished
	get_tree().paused = false
	hide()

func pause():
	get_tree().paused = true


func _on_continuer_button_up() -> void:
	continuer()


func _on_recommencer_button_up() -> void:
	get_tree().reload_current_scene()
	continuer()

func _on_quitter_button_up() -> void:
	get_tree().quit()

func _on_options_button_up() -> void:
	ouvrir_options()
	menu_central.process_mode = Node.PROCESS_MODE_DISABLED

func ouvrir_options():
	if not inst_options :
		inst_options = scene_options.instantiate()
		add_child(inst_options)

func fermer_options():
	menu_central.process_mode = Node.PROCESS_MODE_INHERIT
	if inst_options :
		inst_options.queue_free()
		inst_options = null
	%Continuer.grab_focus()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("menu"):
		if actif:
			continuer()
		else:
			ouvrir()
