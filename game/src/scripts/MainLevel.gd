extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var song = preload("res://src/audio/highscore.mp3")
onready var bullet = load("res://src/scenes/Bullet.tscn")
onready var instructions = load("res://src/scenes/Instructions.tscn")

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
	$Canvas/UI/Score.text = "Score: %s" % $Player.score
	if($Player.position.x > 3767.16):
		$Canvas/UI/Score.visible = true
	if !$Song.is_playing():
		$Song.stream = song
		$Song.play()
