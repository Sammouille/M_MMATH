extends AnimationPlayer



func _on_musique_on_beat(beat: int) -> void:
	if beat == 1:
		play("intro oupi_goupi")
	elif beat == 49:
		play("cercle_to_carre")
	elif beat == 81:
		play("carre_to_trapeze")
	elif beat == 142:
		play("trapeze_to_hex")
	elif beat == 176:
		play("hex_to_square")
	elif beat == 209:
		play("carre_to_cercle")
	elif beat == 274:
		play("cercle_to_carre")
