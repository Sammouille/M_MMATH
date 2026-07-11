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
		%TutoGauche.show()
	elif beat == 9:
		%TutoGauche.hide()
	elif beat == 11:
		%TutoDroit.show()
	elif beat == 18:
		%TutoDroit.hide()
	elif beat == 20:
		%TutoSaut.show()
	elif beat == 26:
		%TutoSaut.hide()
	elif beat == 27:
		%TutoPlane.show()
	elif beat == 31:
		%TutoPlane.hide()
	elif beat == 33:
		%TutoRings1.show()
	elif beat == 40:
		%TutoRings1.hide()
	elif beat == 44:
		%TutoRings2.show()
	elif beat == 52:
		%TutoRings2.hide()
