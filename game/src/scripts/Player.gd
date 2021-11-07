extends KinematicBody2D
class_name Player

export var horizontal_speed = 600.0
export var gravity = 3500.0
export var jump_constant = 1000.0
var velocity = Vector2.ZERO

export var score: int = 0

func _physics_process(delta: float) -> void:
	velocity = move_and_slide(calculate_velocity(delta, velocity))
	#print(velocity, delta)
	#print(get_position())
	if velocity.x == 0:
		print('GAME OVER!')

func calculate_velocity(delta: float, previous_velocity: Vector2) -> Vector2:
	var x = previous_velocity.x + (horizontal_speed * delta)
	var y = previous_velocity.y + (gravity * delta)
	
	if Input.is_action_just_pressed("jump"):
		#print(get_position())
		y -= jump_constant
	
	if x > horizontal_speed:
		x = horizontal_speed
		
	return Vector2(x, y)

# Función para incrementar el score del jugador.
# TODO: tal vez esto tenga que ir a un script especial que maneje los puntos.
func increase_score():
	score += 1
	
	# DEBUG
	print(score)
