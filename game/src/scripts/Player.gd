extends KinematicBody2D
class_name Player

export var horizontal_speed = 600.0
export var gravity = 3500.0
export var jump_constant = 1000.0
var velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity = move_and_slide(calculate_velocity(delta, velocity))
	print(velocity, delta)
	if velocity.x == 0:
		print('GAME OVER!')

func calculate_velocity(delta: float, previous_velocity: Vector2) -> Vector2:
	var x = previous_velocity.x + (horizontal_speed * delta)
	var y = previous_velocity.y + (gravity * delta)
	
	if Input.is_action_just_pressed("jump"):
		y -= jump_constant
	
	if x > horizontal_speed:
		x = horizontal_speed
		
	return Vector2(x, y)
