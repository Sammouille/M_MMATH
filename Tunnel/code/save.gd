extends Resource
class_name SaveGame

const SAVE_GAME_PATH := "user://savegame.tres"

var scores: Array[int] = [0, 0, 0, 0, 0]

func save_file():
	ResourceSaver.save(self, SAVE_GAME_PATH)

func load_file():
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH)
	return null
