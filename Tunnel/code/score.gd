extends Control

var active:= false
var score:= 0.0

var last_score:= 0

@export var scene_figure: PackedScene

@export var timer_grease: Timer

@export var freq_glide:= 0.44
var i_glide:=0.0

var first_grease:= true

var fig_glide
var score_glide:= 0

var fig_grease
var score_grease:= 0

@export var pas_grease:= 4

@export var label: RichTextLabel

var modificateur:= 1.0

func _ready() -> void:
	%Player.touche_sol.connect(end_glide)
	%Grease.area_entered.connect(_on_grease_area_entered)

func end_glide():
	@warning_ignore("narrowing_conversion")
	score_glide *=modificateur
	if fig_glide:
		fig_glide.score.text = "[center][outline_color=black][outline_size=10][font_size=20]%d" %score_glide
		fig_glide.nom.text = "[center][outline_color=black][outline_size=10][font_size=20]glide"
		fig_glide.fin()
		fig_glide = null
	if score_glide:
		score += score_glide
		score_glide = 0
	update_score()

func _process(delta: float) -> void:
	if %Player.i_glide > 88 and !fig_glide:
		i_glide = delta
		score_glide = 1
		fig_glide = scene_figure.instantiate()
		fig_glide.hide()
		$VBoxContainer.add_child(fig_glide)
		fig_glide.nom.text = "[center][outline_color=black][outline_size=10][font_size=15][wave amp=50.0 freq=5.0 connected=1]glide"
		fig_glide.score.text = "[center][outline_color=black][outline_size=10][font_size=15]%d" %score_glide
		fig_glide.show()
	elif %Player.i_glide > 88 and %Player.is_planing:
		i_glide += delta
		fig_glide.score.text = "[center][outline_color=black][outline_size=10][font_size=15]%d" %score_glide
	
	if i_glide >= freq_glide:
		score_glide *= 2
		i_glide -= freq_glide
		
	
	
	if active:
		#if !%Player.in_air:
			#score += delta * 0.86 * modificateur
		
		if last_score != int(score) or (%Player.in_air and modificateur != 1.0):
			update_score()
	last_score = int(score)

func update_score():
	label.text = "[center][outline_color=black][outline_size=10][font_size=30]Score"
	#if %Player.in_air:
		#label.text +=" x %.1f
#%0*d" % [0,5,int(score)]
	if modificateur != 1.0:
		label.text +="[rainbow freq=5.0 sat=0.5 val=0.9 speed=0.3] x %.1f
%0*d" % [modificateur,5,int(score)]
	else:
		label.text +="
%0*d" % [5,int(score)]
		

func grease():
	timer_grease.start()
	if !fig_grease:
		score_grease = 1
		fig_grease = scene_figure.instantiate()
		fig_grease.hide()
		$VBoxContainer.add_child(fig_grease)
		fig_grease.nom.text = "[center][outline_color=black][outline_size=10][font_size=15][wave amp=50.0 freq=5.0 connected=1]grease"
		fig_grease.score.text = "[center][outline_color=black][outline_size=10][font_size=15]%d" %score_grease
		fig_grease.show()
	else:
		score_grease += pas_grease
		fig_grease.score.text = "[center][outline_color=black][outline_size=10][font_size=15]%d" %score_grease

func _on_musique_on_beat(beat: int) -> void:
	if beat == 24:
		active = true


func _on_timer_grease_timeout() -> void:
	@warning_ignore("narrowing_conversion")
	score_grease *= modificateur
	if fig_grease:
		fig_grease.score.text = "[center][outline_color=black][outline_size=10][font_size=20]%d" %score_grease
		fig_grease.nom.text = "[center][outline_color=black][outline_size=10][font_size=20]grease"
		fig_grease.fin()
		fig_grease = null
	if score_grease:
		score += score_grease
		score_grease = 0
	update_score()


func _on_grease_area_entered(_area: Area3D) -> void:
	if first_grease:
		first_grease = false
	else:
		grease()
