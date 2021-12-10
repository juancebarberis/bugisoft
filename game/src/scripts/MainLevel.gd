extends Node2D

onready var song = preload("res://src/audio/highscore.mp3")
onready var instructions = load("res://src/scenes/Instructions.tscn")
onready var file_system = preload("res://src/scripts/FileSystem.gd").new()

const LEVEL_NAME = "Level 1"
const X_START = 3767.16
const X_END = 54257.0
const X_TOTAL = X_END - X_START

export var level_completed = false

func _ready():
	play_song()
	add_instructions()

func _process(_delta):
	update_progress_bar()

func add_instructions():
	var inst = instructions.instance()
	add_child(inst)

func restart_level():
	if not level_completed:
		print("You lost :(")
		queue_free()
		print("Restarting game...")
		get_tree().change_scene("res://src/scenes/MainLevel.tscn")
	else: 
		show_level_complete_ui()

func show_level_complete_ui():
	$Canvas/LevelCompleteUI.visible = true
	$Canvas/LevelCompleteUI/ScoreAdvise.text = "Obtuviste una puntuacion de: %s" % $Player.score

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
		level_completed = true
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
