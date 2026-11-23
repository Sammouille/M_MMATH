extends Control

const SAVE_CONFIG_PATH := "user://saveconfig.tres"

var config_handler:= ConfigHandler.new()

@onready var volume_slider = find_child("VolumeSlider")
@onready var voices_volume_slider = find_child("VoicesVolumeSlider")
@onready var sfx_volume_slider = find_child("SFXVolumeSlider")
@onready var music_volume_slider = find_child("MusicVolumeSlider")
@onready var window_mode = find_child("ModeAffichageOption")
@onready var window_size = find_child("ResolutionOption")

@onready var maxfps_slider = find_child("MaxFPSSlider")

@onready var parent_menu = get_parent()

@onready var anim_player : AnimationPlayer = find_child("AnimationPlayer")


func _ready() -> void:
	anim_player.play("menu_on")
	
	config_handler.load_all()
	
	volume_slider.value = config_handler.volume
	voices_volume_slider.value = config_handler.bark_volume
	sfx_volume_slider.value = config_handler.sfx_volume
	music_volume_slider.value = config_handler.music_volume
	maxfps_slider.value = config_handler.max_fps
	window_mode.selected = config_handler.window_mode
	window_size.selected = config_handler.window_size


func turning_off():
	config_handler.save_config()
	anim_player.play("menu_off")
	
	await anim_player.animation_finished
	
	parent_menu.fermer_options()
	

func _on_volume_slider_value_changed(value: float) -> void:
	config_handler.volume = value
	AudioServer.set_bus_volume_db(0, value)

func _on_voices_volume_slider_value_changed(value: float) -> void:
	config_handler.bark_volume = value
	AudioServer.set_bus_volume_db(3, value)

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	config_handler.sfx_volume = value
	AudioServer.set_bus_volume_db(2, value)

func _on_music_volume_slider_value_changed(value: float) -> void:
	config_handler.music_volume = value
	AudioServer.set_bus_volume_db(1, value)



func _on_resolution_option_item_selected(index: int) -> void:
	config_handler.window_size = index
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600,900))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))
		3:
			DisplayServer.window_set_size(Vector2i(1152,648))
		4:
			DisplayServer.window_set_size(Vector2i(854,480))
		5:
			DisplayServer.window_set_size(Vector2i(640,360))


func _on_mode_affichage_option_item_selected(index: int) -> void:
	config_handler.window_mode = index
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)


func _on_max_fps_slider_value_changed(value: float) -> void:
	config_handler.max_fps = int(value)
	Engine.max_fps = int(value)
	%MaxFPSTitre.text = "[center]Max FPS (%d)" % int(value)


func _on_retour_button_button_up() -> void:
	turning_off()
