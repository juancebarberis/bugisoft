extends Node2D


onready var song = preload("res://src/audio/highscore.mp3")
onready var instructions = load("res://src/scenes/Instructions.tscn")

func _ready():
	var inst = instructions.instance()
	add_child(inst)

func _process(_delta):
	$Canvas/UI/Score.text = "Score: %s" % $Player.score
	if($Player.position.x > 3767.16):
		$Canvas/UI/Score.visible = true
	if !$Song.is_playing():
		$Song.stream = song
		$Song.play()
