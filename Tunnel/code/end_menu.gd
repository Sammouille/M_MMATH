extends Control

@export var restart_button: Button

@export var index_level: String = "1a"

var text_highscore:= "[center][wave amp=50.0 freq=5.0 connected=1]New HIGHSCORE!"

const SAVE_GAME_PATH := "user://savegame.tres"

var config_handler:= ConfigHandler.new()

var finished:= false


func show_menu(_finished: bool, final_score: int):
	finished = _finished
	
	if finished:
		%ScoreFinal.text = "[center]Flight succeed !
Score : %0*d" % [5,int(final_score)]
		config_handler.load_all()
		if config_handler.new_score(index_level, final_score):
			%Comparator.text = text_highscore
		else:
			%Comparator.text = "[center]Highscore : %0*d" % [5,int(config_handler.scores.get(index_level))]
		%Comparator.show()
		%Continue.disabled = false
		%Continue.grab_focus()
	
	# Cas spécial pour dernier niçveau ?
	#elif index_level > 4:
		#%Quit.grab_focus()
		#%Continue.disabled = true
	
	else:
		%ScoreFinal.text = "[center]Game over !
Score : %0*d" % [5,int(final_score)]
		%Continue.disabled = true
		restart_button.grab_focus()
	
	
	show()


func _restart():
	get_tree().reload_current_scene()

func _on_continue_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	pass # Replace with function body.
