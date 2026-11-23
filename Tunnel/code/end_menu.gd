extends Control

@export var restart_button: Button

@export var index_level:= 0

const SAVE_GAME_PATH := "user://savegame.tres"

var finished:= false

var final_score:= 0

func show_menu(_finished: bool, _final_score: int):
	finished = _finished
	final_score = _final_score
	
	if finished:
		%ScoreFinal.text = "[center]Flight succeed !
Score : %0*d" % [5,int(final_score)]
	else:
		%ScoreFinal.text = "[center]Game over !
Score : %0*d" % [5,int(final_score)]

	if finished and index_level < 4:
		check_for_save()
		%Continue.disabled = false
		%Continue.grab_focus()
	elif index_level > 4:
		%Quit.grab_focus()
		%Continue.disabled = true
	else:
		%Continue.disabled = true
		restart_button.grab_focus()
	
	show()

func check_for_save():
	var save_file : SaveGame
	if ResourceLoader.exists(SAVE_GAME_PATH):
		save_file = load(SAVE_GAME_PATH)
	else:
		save_file = SaveGame.new()
	if save_file.scores[index_level] < final_score:
		save_file.scores[index_level] = final_score
		save_file.save_file()

func _restart():
	get_tree().reload_current_scene()

func _on_continue_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	pass # Replace with function body.
