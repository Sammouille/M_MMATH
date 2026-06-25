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
	if beat == 3:
		%TutoGauche.show()
	elif beat == 8:
		%TutoGauche.hide()
	elif beat == 18:
		%TutoDroit.show()
	elif beat == 22:
		%TutoDroit.hide()
	elif beat == 34:
		%TutoRings1.show()
	elif beat == 39:
		%TutoRings1.hide()
	elif beat == 43:
		%TutoRings2.show()
	elif beat == 48:
		%TutoRings2.hide()
	elif beat == 52:
		%TutoSaut.show()
	elif beat == 55:
		%TutoSaut.hide()
	elif beat == 56:
		%TutoPlane.show()
	elif beat == 63:
		%TutoPlane.hide()
