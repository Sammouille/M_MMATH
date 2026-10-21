extends AnimationPlayer



func _on_musique_on_beat(beat: int) -> void:
	if beat == 15:
		play("barre_to_rond")
