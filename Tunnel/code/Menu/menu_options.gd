extends Control


@onready var volume_slider = find_child("VolumeSlider")
@onready var voices_volume_slider = find_child("VoicesVolumeSlider")
@onready var sfx_volume_slider = find_child("SFXVolumeSlider")
@onready var music_volume_slider = find_child("MusicVolumeSlider")

@onready var maxfps_slider = find_child("MaxFPSSlider")

@onready var parent_menu = get_parent()

@onready var anim_player : AnimationPlayer = find_child("AnimationPlayer")

func _ready() -> void:
	anim_player.play("menu_on")
	volume_slider.value = AudioServer.get_bus_volume_db(0)
	voices_volume_slider.value = AudioServer.get_bus_volume_db(1)
	sfx_volume_slider.value = AudioServer.get_bus_volume_db(2)
	music_volume_slider.value = AudioServer.get_bus_volume_db(3)
	maxfps_slider.value = Engine.max_fps


func turning_off():
	anim_player.play("menu_off")
	
	await anim_player.animation_finished
	
	parent_menu.fermer_options()
	

func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)

func _on_voices_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(3, value)

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, value)

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, value)



func _on_resolution_option_item_selected(index: int) -> void:
	match index:
		0:
			#get_window().content_scale_size = Vector2i(1920,1080)
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			#get_window().content_scale_size = Vector2i(1600,900)
			#print(get_window().is_embedded())
			
			DisplayServer.window_set_size(Vector2i(1600,900))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))
			#get_window().content_scale_size = Vector2i(1280,720)
		3:
			DisplayServer.window_set_size(Vector2i(1152,648))
			#get_window().content_scale_size = Vector2i(1152,648)
		4:
			DisplayServer.window_set_size(Vector2i(854,480))
			#get_window().content_scale_size = Vector2i(854,480)
		5:
			DisplayServer.window_set_size(Vector2i(640,360))
			#get_window().content_scale_size = Vector2i(640,360)


func _on_mode_affichage_option_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)


func _on_max_fps_slider_value_changed(value: float) -> void:
	Engine.max_fps = int(value)


func _on_retour_button_button_up() -> void:
	turning_off()
