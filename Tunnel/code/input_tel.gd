extends Control


func _on_dep_g_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			var fake_event = InputEventAction.new()
			fake_event.action = "gauche"
			fake_event.pressed = true
			Input.parse_input_event(fake_event)
		else:
			var fake_event = InputEventAction.new()
			fake_event.action = "gauche"
			fake_event.pressed = false
			Input.parse_input_event(fake_event)


func _on_dep_d_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			var fake_event = InputEventAction.new()
			fake_event.action = "droite"
			fake_event.pressed = true
			Input.parse_input_event(fake_event)
		else:
			var fake_event = InputEventAction.new()
			fake_event.action = "droite"
			fake_event.pressed = false
			Input.parse_input_event(fake_event)


func _on_saut_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			var fake_event = InputEventAction.new()
			fake_event.action = "jump"
			fake_event.pressed = true
			Input.parse_input_event(fake_event)
		else:
			var fake_event = InputEventAction.new()
			fake_event.action = "jump"
			fake_event.pressed = false
			Input.parse_input_event(fake_event)


func _on_musique_on_beat(beat: int) -> void:
	if beat == 2:
		%TutoDroit.show()
	elif beat == 9:
		%TutoDroit.hide()
	elif beat == 10:
		%TutoGauche.show()
	elif beat == 17:
		%TutoGauche.hide()
	elif beat == 26:
		%TutoSaut.show()
	elif beat == 33:
		%TutoSaut.hide()
	elif beat == 34:
		%TutoPlane.show()
	elif beat == 41:
		%TutoPlane.hide()
