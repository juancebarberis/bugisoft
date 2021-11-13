extends KinematicBody2D
class_name Player

export var speed: = Vector2(300.0, 1000.0)
export var gravity = 3500.0
export var jump_constant = 1000.0
export var score: int = 0
export var old_score: int = 0
export var boost: int = 0


const FLOOR_NORMAL: = Vector2.UP
var velocity = Vector2.ZERO

func _on_BulletDetector_body_entered(body: Bullet) -> void:
	print("You lost :(")
	queue_free()
	print("Restarting game...")
	get_tree().change_scene("res://src/scenes/MainLevel.tscn")

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: bool = Input.is_action_just_released("jump") and velocity.y < 0.0
	
	velocity = calculate_velocity(delta, velocity, is_jump_interrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

func _get_direction_y() -> float:
	return -1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0

func _process(_delta):
	if Input.is_key_pressed(KEY_X):
		$AnimationPlayer.play("Giro")

func calculate_velocity(delta: float, previous_velocity: Vector2, is_jump_interrupted: bool) -> Vector2:
	var new_velocity: = previous_velocity
	new_velocity.x += (speed.x * delta)
	new_velocity.y += (gravity * delta)
	
	var direction_y: = _get_direction_y()
	if direction_y == -1.0:
		new_velocity.y = speed.y * direction_y
	if is_jump_interrupted:
		new_velocity.y = 0.0
		
	new_velocity.x = min(new_velocity.x, speed.x)
	
	if old_score < score:
		new_velocity.x += boost
	
	return new_velocity

func increase_boost():
	boost += 30

# Función para incrementar el score del jugador.
# TODO: tal vez esto tenga que ir a un script especial que maneje los puntos.
func increase_score():
	old_score = score
	score += 1
	
	# DEBUG
	print(score)
