extends AnimationPlayer



func _on_musique_on_beat(beat: int) -> void:
	if beat == 57:
		play("rond_to_triangle")
	if beat == 118:
		play("triangle_to_hexa")
	if beat == 198:
		play("hexa_to_rond")
