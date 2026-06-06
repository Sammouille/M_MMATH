extends Control

var score:= 0.0

var last_score:= 0

@export var scene_figure: PackedScene

@export var timer_grease: Timer

@export var freq_glide:= 0.66
var i_glide:=0.0

@export var mod_decay:= 0.1

var first_grease:= true

var fig_glide
var score_glide:= 0

var fig_grease_combo
var score_grease:= 0
var index_grease:= 0

@export var pas_grease:= 4

@export var label: RichTextLabel

var modificateur:= 1.0

var index_bonus:= 0

func _ready() -> void:
	%Player.touche_sol.connect(end_glide)
	%Grease.area_entered.connect(_on_grease_area_entered)

func _on_huge_ring_passed():
	var score_ring:= 444 * modificateur
	
	var fig_ring = scene_figure.instantiate()
	fig_ring.hide()
	$VBoxContainer.add_child(fig_ring)
	fig_ring.score.text = "[center][outline_color=black][outline_size=10][font_size=25]%d" %score_ring
	fig_ring.nom.text = "[center][outline_color=black][outline_size=10][font_size=25]huge_ring ring"
	fig_ring.show()
	fig_ring.fin()
	score += score_ring
	update_score()

func bonus_modificateur():
	%Bonus.play()
	%Player.after_image.ghost_lifetime += 0.3
	modificateur = float(int(roundf(modificateur + 1.4)))
	%Bonus.pitch_scale = 1.0 + index_bonus * 0.1
	index_bonus += 1
	
	var score_ring:= 100 * modificateur
	
	var fig_ring = scene_figure.instantiate()
	fig_ring.hide()
	$VBoxContainer.add_child(fig_ring)
	fig_ring.score.text = "[center][outline_color=black][outline_size=10][font_size=25]%d" %score_ring
	fig_ring.nom.text = "[center][outline_color=black][outline_size=10][font_size=25]bonus ring"
	fig_ring.show()
	fig_ring.fin()
	score += score_ring
	update_score()

func end_glide():
	@warning_ignore("narrowing_conversion")
	score_glide *=modificateur
	if fig_glide:
		fig_glide.score.text = "[center][outline_color=black][outline_size=10][font_size=25]%d" %score_glide
		fig_glide.nom.text = "[center][outline_color=black][outline_size=10][font_size=25]glide"
		fig_glide.fin()
		fig_glide = null
	if score_glide:
		score += score_glide
		score_glide = 0
	update_score()

func _process(delta: float) -> void:
	if %Player.i_glide > 44 and !fig_glide:
		i_glide = delta
		score_glide = 1
		fig_glide = scene_figure.instantiate()
		fig_glide.hide()
		$VBoxContainer.add_child(fig_glide)
		fig_glide.nom.text = "[center][outline_color=black][outline_size=10][font_size=25][shake rate=80.0 level=16 connected=1]glide"
		fig_glide.score.text = "[center][outline_color=black][outline_size=10][font_size=25]%d" %score_glide
		fig_glide.show()
	elif %Player.i_glide > 44 and %Player.is_planing:
		i_glide += delta
		fig_glide.score.text = "[center][outline_color=black][outline_size=10][font_size=25]%d" %score_glide
	
	if i_glide >= freq_glide:
		score_glide *= 2
		i_glide -= freq_glide
		
	
	if modificateur > 1.0:
		%Mod.show()
		modificateur -= mod_decay * delta * modificateur
		%Player.after_image.ghost_lifetime = minf(1.0, (modificateur -1.0)*0.1)
		%Mod.text = "[center][outline_color=black][outline_size=10][font_size=%d][rainbow freq=1.0 sat=%.1f val=0.8 speed=1.0]* %.1f" % [30+ modificateur * 4, minf(modificateur * 0.2, 1.0), modificateur]
	elif %Player.after_image.ghost_lifetime != 0.0:
		%Player.after_image.ghost_lifetime = 0.0
	else:
		modificateur = 1.0
		index_bonus = 0
		%Mod.hide()
	
	if last_score != int(score) or (%Player.in_air and modificateur != 1.0):
			update_score()
	last_score = int(score)

func update_score():
	label.text = "[center][outline_color=black][outline_size=10][font_size=40]Score"
	#if %Player.in_air:
		#label.text +=" x %.1f
#%0*d" % [0,5,int(score)]
	#if modificateur != 1.0:
		#label.text +="[rainbow freq=5.0 sat=0.5 val=0.9 speed=0.3] x %.1f
#%0*d" % [modificateur,5,int(score)]
	#else:
	label.text +="
%0*d" % [5,int(score)]
		

func grease():
	%SonGrease.pitch_scale = 1.0 + 0.1*float(index_grease)
	%SonGrease.play()
	index_grease += 1
	
	
	update_score()
	var fig_grease = scene_figure.instantiate()
	fig_grease = scene_figure.instantiate()
	fig_grease.hide()
	$VBoxContainer.add_child(fig_grease)
	fig_grease.nom.text = "[center][outline_color=black][outline_size=10][font_size=25]grease"
	fig_grease.score.text = "[center][outline_color=black][outline_size=10][font_size=25]%d" % int(2.0 * modificateur)
	fig_grease.show()
	score += 2.0 * modificateur
	fig_grease.fin()
	update_score()
	
	timer_grease.start()
	
	if index_grease > 1:
			
		if !fig_grease_combo:
			score_grease = 1
			fig_grease_combo = scene_figure.instantiate()
			fig_grease_combo.hide()
			$VBoxContainer.add_child(fig_grease_combo)
			fig_grease_combo.nom.text = "[center][outline_color=black][outline_size=10][font_size=25][shake rate=80.0 level=16 connected=1]grease combo"
			fig_grease_combo.score.text = "[center][outline_color=black][outline_size=10][font_size=25]%d" %score_grease
			fig_grease_combo.show()
		else:
			score_grease += index_grease * 0.5
			fig_grease_combo.score.text = "[center][outline_color=black][outline_size=10][font_size=25]%d" %score_grease


func _on_timer_grease_timeout() -> void:
	@warning_ignore("narrowing_conversion")
	index_grease = 0
	score_grease *= modificateur
	if fig_grease_combo:
		fig_grease_combo.score.text = "[center][outline_color=black][outline_size=10][font_size=25]%d" %score_grease
		fig_grease_combo.nom.text = "[center][outline_color=black][outline_size=10][font_size=25]grease combo"
		fig_grease_combo.fin()
		fig_grease_combo = null
	if score_grease:
		score += score_grease
		score_grease = 0
	update_score()


func _on_grease_area_entered(_area: Area3D) -> void:
	if first_grease:
		first_grease = false
	else:
		grease()

func _fin(reussite:= false):
	if reussite:
		%ScoreFinal.text = "[center]Flight succeed !
Score : %0*d" % [5,int(%Score.score)]
	else:
		%ScoreFinal.text = "[center]Game over !
Score : %0*d" % [5,int(%Score.score)]
	%EndMenu.show()
	%EndMenu.restart_button.grab_focus()


func _on_musique_on_beat(beat: int) -> void:
	if beat == 312:
		_fin(true)
