extends Node2D

onready var song = preload("res://src/audio/highscore.mp3")
onready var instructions = load("res://src/scenes/Instructions.tscn")
onready var file_system = preload("res://src/scripts/FileSystem.gd").new()

const LEVEL_NAME = "Level 1"
const X_START = 3767.16
const X_END = 34257.0
const X_TOTAL = X_END - X_START

func _ready():
	play_song()
	add_instructions()
	#add_bullets(8)

func _process(_delta):
	update_progress_bar()

func add_instructions():
	var inst = instructions.instance()
	add_child(inst)


#func add_bullets(number_of_bullets):
#	for i in range(number_of_bullets):
#			var b = bullet.instance()
#			add_child(b)
#			var position_x = 8000*i
#			var position_y = 700
#			var speed =  50.0 / (i + 1.0)
#			b.init(position_x, position_y, speed)


func update_score():
	# updates score shown
	$Canvas/GameUI/Score.text = "Score: %s" % $Player.score

func update_progress_bar():
	$Canvas/GameUI/LevelProgress.value = _path_traveled($Player.position.x)

func _path_traveled(position_x):
	# returns percentage of path traveled
	var path_traveled =  position_x - X_START
	var percentage = ( path_traveled / X_TOTAL ) * 100
	if int(percentage) == 100:
		file_system.add_score_to_ranking($Player.score, LEVEL_NAME)
	return percentage

func play_song():
	# plays song if not already playing
	if !$Song.is_playing():
		$Song.stream = song
		$Song.play()
		
func _update_debug(message: String):
	$Canvas/GameUI/_debug.text = "Debug: " + message

func show_game_ui():
	$Canvas/GameUI.show()

func get_player():
	return $Player

func chromatic_abb():
	$Canvas/Shader.chromatic_abb()

func seek_song(seek_value: float):
	$Song.seek(seek_value)
