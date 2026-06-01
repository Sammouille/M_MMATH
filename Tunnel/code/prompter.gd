extends Control

@export var label: RichTextLabel

@export_multiline() var lines: Array[String]
@export_multiline() var formating:= ""

@export var index_line:= 0


func afficher_texte():
	if index_line >= lines.size() :
		index_line = 0
	label.text = formating + lines[index_line]
	index_line += 1
	label.show()
	await get_tree().create_timer(8.8).timeout
	label.hide()
