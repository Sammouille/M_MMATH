extends Control

@export_multiline() var array_controler: Array[String]
@export_multiline() var array_keyboard: Array[String]

@export var array_tutos: Array[RichTextLabel]

var keyboard:= true

func _ready() -> void:
	
	$Panel/MarginContainer/VBoxContainer/Keyboard.grab_focus()

func lancer():
	hide()
	for i in range(array_tutos.size()):
		if keyboard:
			array_tutos[i].text = array_keyboard[i]
		else:
			array_tutos[i].text = array_controler[i]
	
	%Musique.play()
	

func _on_controler_pressed() -> void:
	keyboard = false
	lancer()

func _on_keyboard_pressed() -> void:
	keyboard = true
	lancer()
