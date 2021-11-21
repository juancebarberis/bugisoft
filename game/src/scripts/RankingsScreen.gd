extends Node2D

onready var file_system = preload("res://src/scripts/FileSystem.gd").new()
const LIST_HEADER = "NAME | DATE | LEVEL | SCORE"

func _ready():
	# Initialize the screen
	visible = false
	
	render_scores_on_list()

func render_scores_on_list():
	var rankings = file_system.get_local_rankings()
	# List header
	$RankingsList.add_item("Name", null, false)
	$RankingsList.add_item("Date", null, false)
	$RankingsList.add_item("Level", null, false)
	$RankingsList.add_item("Score", null, false)
	
	# List items
	rankings.invert()
	for ranking in rankings:
		$RankingsList.add_item(ranking.player_name, null, false)
		$RankingsList.add_item(format_date_for_ranking(ranking.time), null, false)
		$RankingsList.add_item(ranking.level, null, false)
		$RankingsList.add_item(String(ranking.score), null, false)

func format_date_for_ranking(date_time):
	var weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
	var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
	var result = "%02d %s %d %02d:%02d:%02d" % [date_time.day, months[date_time.month-1], date_time.year, date_time.hour, date_time.minute, date_time.second]
	return result

func _on_BackToMenuButton_pressed() -> void:
	var parent = get_parent()
	hide()
	parent.show()
	parent.show_main_menu_screen()
