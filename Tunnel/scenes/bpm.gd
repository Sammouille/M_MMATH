extends Control

@export var label: RichTextLabel

func _on_musique_on_beat(beat: int) -> void:
	label.text = "[center][outline_color=black][outline_size=10]Beat
%d" % beat
