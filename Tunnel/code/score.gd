extends Control

var active:= false
var score:= 0.0

var last_score:= 0

@export var label: RichTextLabel

var modificateur:= 1.0

func _process(delta: float) -> void:
	if active:
		#if !%Player.in_air:
			#score += delta * 0.86 * modificateur
		
		if last_score != int(score) or (%Player.in_air and modificateur != 1.0):
			update_score()
	last_score = int(score)

func update_score():
	label.text = "[center][outline_color=black][outline_size=10]Score"
	#if %Player.in_air:
		#label.text +=" x %.1f
#%0*d" % [0,5,int(score)]
	if modificateur != 1.0:
		label.text +="[rainbow freq=5.0 sat=0.5 val=0.9 speed=0.3] x %.1f
%0*d" % [modificateur,5,int(score)]
	else:
		label.text +="
%0*d" % [5,int(score)]
		

func _on_musique_on_beat(beat: int) -> void:
	if beat == 24:
		active = true
