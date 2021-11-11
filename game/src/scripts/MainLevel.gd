extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var song = preload("res://src/audio/highscore.mp3")
onready var bullet = load("res://src/scenes/Bullet.tscn")
onready var instructions = load("res://src/scenes/Instructions.tscn")

var posicion_x_inicio = 3767.16
var posicion_x_final = 34257
var recorrido_total = posicion_x_final - posicion_x_inicio

# Called when the node enters the scene tree for the first time.
func _ready():
	var inst = instructions.instance()
	add_child(inst)
	for i in range(5):
		var b = bullet.instance()
		add_child(b)
		b.init(8000*i, 700, float(50)/float(i+1))
	
	

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Canvas/UI/LevelProgress.value = ( float($Player.position.x - posicion_x_inicio) / float(recorrido_total) ) * 100
	$Canvas/UI/Score.text = "Score: %s" % $Player.score

	if($Player.position.x > 3767.16):
		$Canvas/UI/LevelProgress.visible = true;
		$Canvas/UI/Score.visible = true
	if !$Song.is_playing():
		$Song.stream = song
		$Song.play()
