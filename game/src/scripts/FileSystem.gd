extends Node

class_name FileSystem

# All FS related operations are here.

const USER_DATA_PATH = "user://fiubatrydash_user.data"
const RANKINGS_DATA_PATH = "user://fiubatrydash_rankings.data"
var saved = false


func get_nickname_from_user_data():
	# Try to get the user's nickname saved on the FS
	# If the user doesn't register a nickname, we just return an empty string
	var file = File.new()
	var saved_nickname = ""
	
	if file.file_exists(USER_DATA_PATH):
		file.open(USER_DATA_PATH, File.READ)
		saved_nickname = file.get_as_text().strip_escapes()
		file.close()
	return saved_nickname
	
func set_nickname_on_user_data(nickname):
	# Sets the nickname on the FS
	var file = File.new()
	file.open(USER_DATA_PATH, File.WRITE)
	file.store_line(nickname)

func add_score_to_ranking(score: int, level: String):
	if not saved:
		var current_time = OS.get_datetime()
		var nickname = get_nickname_from_user_data()
		save_to_local_ranking_file({
			"player_name": nickname,
			"time": current_time,
			"score": score,
			"level": level
		})
		saved = true

func save_to_local_ranking_file(ranking_data: Dictionary):
	# Store ranking line in base64 format to a file in the user's file system
	var ranking_file = File.new()
	var json_string = JSON.print(ranking_data)
	
	if ranking_file.file_exists(RANKINGS_DATA_PATH):
		ranking_file.open(RANKINGS_DATA_PATH, File.READ_WRITE)
	else:
		ranking_file.open(RANKINGS_DATA_PATH, File.WRITE)
		
	ranking_file.seek_end()
	ranking_file.store_line(json_string)
	ranking_file.close()

func get_local_rankings():
	var ranking_file = File.new()
	
	if not ranking_file.file_exists(RANKINGS_DATA_PATH):
		return []
	
	ranking_file.open(RANKINGS_DATA_PATH, File.READ)
	var rankings = []
	var decoded_json
	var line = ranking_file.get_line()
	while line:
		decoded_json = JSON.parse(line)
		if decoded_json.error == OK:
			rankings.append(decoded_json.get_result())
		line = ranking_file.get_line()
	return rankings
