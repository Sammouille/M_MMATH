extends Resource
class_name SaveConfig

const SAVE_CONFIG_PATH := "user://saveconfig.tres"

var max_fps: int = 0
var window_mode: int = 0
var window_size: int = 0
var volume: float = 0.0
var bark_volume: float = 0.0
var sfx_volume: float = 0.0
var music_volume: float = 0.0

func apply_config():
	Engine.max_fps = max_fps
	AudioServer.set_bus_volume_db(0, volume)
	AudioServer.set_bus_volume_db(3, bark_volume)
	AudioServer.set_bus_volume_db(2, sfx_volume)
	AudioServer.set_bus_volume_db(1, music_volume)
	match window_size:
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
	
	match window_mode:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)


func save_file():
	ResourceSaver.save(self, SAVE_CONFIG_PATH)

func load_file():
	if ResourceLoader.exists(SAVE_CONFIG_PATH):
		return load(SAVE_CONFIG_PATH)
	return null
