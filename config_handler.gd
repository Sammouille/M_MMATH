extends RefCounted
class_name ConfigHandler

var config:= ConfigFile.new()
var path:= "user://mmmath.cfg"

var max_fps: int = 0
var window_mode: int = 0
var window_size: int = 3
var volume: float = 0.0
var bark_volume: float = 0.0
var sfx_volume: float = 0.0
var music_volume: float = 0.0

var scores:= {"1a": 0, "2a": 0, "3": 0, "2b": 0, "1b": 0}

func init_all():
	config.set_value("VIDEO", "max_fps", max_fps)
	config.set_value("VIDEO", "window_mode", window_mode)
	config.set_value("VIDEO", "window_size", window_size)
	config.set_value("AUDIO", "master", volume)
	config.set_value("AUDIO", "bark", bark_volume)
	config.set_value("AUDIO", "sfx", sfx_volume)
	config.set_value("AUDIO", "music", music_volume)
	config.set_value("GAME", "highscores", scores)
	config.save(path)

func save_config():
	config.set_value("VIDEO", "max_fps", max_fps)
	config.set_value("VIDEO", "window_mode", window_mode)
	config.set_value("VIDEO", "window_size", window_size)
	config.set_value("AUDIO", "master", volume)
	config.set_value("AUDIO", "bark", bark_volume)
	config.set_value("AUDIO", "sfx", sfx_volume)
	config.set_value("AUDIO", "music", music_volume)
	config.save(path)

func save_score():
	config.set_value("GAME", "highscores", scores)
	config.save(path)

func load_all():
	if config.load(path) != OK:
		init_all()
	else:
		max_fps = config.get_value("VIDEO", "max_fps")
		window_mode = config.get_value("VIDEO", "window_mode")
		window_size = config.get_value("VIDEO", "window_size")
		volume = config.get_value("AUDIO", "master")
		bark_volume = config.get_value("AUDIO", "bark")
		sfx_volume = config.get_value("AUDIO", "sfx")
		music_volume = config.get_value("AUDIO", "music")
		scores = config.get_value("GAME", "highscores")

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

func new_score(level: String, score: int):
	if scores.has(level):
		if scores.get(level) < score:
			scores.set(level, score)
			save_score()
			return true
		else:
			return false
		
		
