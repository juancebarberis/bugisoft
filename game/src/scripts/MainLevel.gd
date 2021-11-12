extends Node2D

onready var song = preload("res://src/audio/highscore.mp3")
onready var bullet = load("res://src/scenes/Bullet.tscn")
onready var instructions = load("res://src/scenes/Instructions.tscn")


const X_START = 3767.16
const X_END = 34257.0
const X_TOTAL = X_END - X_START

func _ready():
	add_instructions()
	add_bullets(8)

func _process(_delta):
	if($Player.position.x > X_START):
		$Canvas/UI/LevelProgress.visible = true;
		$Canvas/UI/Score.visible = true
	update_score()
	play_song()
	update_progress_bar()

func add_instructions():
	var inst = instructions.instance()
	add_child(inst)


func add_bullets(number_of_bullets):
	for i in range(number_of_bullets):
			var b = bullet.instance()
			add_child(b)
			var position_x = 8000*i
			var position_y = 700
			var speed =  50.0 / (i + 1.0)
			b.init(position_x, position_y, speed)


func update_score():
	$Canvas/UI/Score.text = "Score: %s" % $Player.score

func update_progress_bar():
	$Canvas/UI/LevelProgress.value = path_traveled($Player.position.x)

func path_traveled(position_x):
	var path_traveled =  position_x - X_START
	return ( path_traveled / X_TOTAL ) * 100

func play_song():
	if !$Song.is_playing():
		$Song.stream = song
		$Song.play()
