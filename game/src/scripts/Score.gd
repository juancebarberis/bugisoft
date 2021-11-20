extends Label

class_name Score

const GAME_DATA_PATH = "user://game_rankings.data"

var saved = false

func _ready():
	# Every time the player ends a Level, we store the score here.
	pass

func add_score_to_ranking(player_name: String, score: int, level: String):
	if not saved:
		var current_time = OS.get_datetime()
		save_to_local_ranking_file({
			"player_name": player_name,
			"time": current_time,
			"score": score,
			"level": level
		})
		saved = true

func save_to_local_ranking_file(ranking_data: Dictionary):
	# Store ranking line in base64 format to a file in the user's file system
	var ranking_file = File.new()
	var json_string = JSON.print(ranking_data)
	
	if ranking_file.file_exists(GAME_DATA_PATH):
		ranking_file.open(GAME_DATA_PATH, File.READ_WRITE)
	else:
		ranking_file.open(GAME_DATA_PATH, File.WRITE)
		
	ranking_file.seek_end()
	# Base 64 encoding is just a simple layer to avoid data handling	
	ranking_file.store_line(Marshalls.utf8_to_base64(json_string))
