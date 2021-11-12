extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var vel = 0;
signal exited_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	var _error_code = connect("exited_signal", self, "on_exited_signal")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (position.x < 0):
		emit_signal("exited_signal")
	position.x -= vel

func init(x, y, vel_i):
	position.x = x
	position.y = y
	vel = vel_i

func on_exited_signal():
	queue_free()


func _on_Bullet_body_entered(body):
	if body is KinematicBody2D:
		print ("BULLET HIT")
 # Replace with function body.
