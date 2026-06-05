extends Control

@export var label: RichTextLabel
@export var label_line: RichTextLabel

func _on_musique_on_beat(beat: int) -> void:
	label.text = "[center][outline_color=black][outline_size=10][font_size=25]Beat
%d" % beat


func _on_gestionnaire_colonnes_deplacement_colonne(i_colonne: int) -> void:
	label_line.text = "[center][outline_color=black][outline_size=10][font_size=25]Line
%d" % i_colonne
