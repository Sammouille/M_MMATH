extends AnimationPlayer



func _on_musique_on_beat(beat: int) -> void:
	if beat == 15:
		play("barre_to_rond")
	
	if beat == 138 or beat == 345:
		play("rond_to_carre")
	
	if beat == 230 or beat == 420:
		play("carre_to_rond")
