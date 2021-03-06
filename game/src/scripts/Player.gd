extends KinematicBody2D
class_name Player

export var speed: = Vector2(300.0, 1000.0)
export var gravity = 3500.0
export var jump_constant = 1000.0
export var score: int = 0
export var old_score: int = 0
export var boost: int = 0
export var jump_platf_impulse = 1400.0
export var portal_reduction_of_vel = 20

const INITIAL_POSITION = Vector2(264.333, 481.202)
const FLOOR_NORMAL: = Vector2.UP
var velocity = Vector2.ZERO
var gravity_inverted = false

func _ready():
	position = INITIAL_POSITION
	pass

func _on_BulletDetector_body_entered(body: Bullet) -> void:
	restart_level()

func restart_level():
	var parent = get_parent()
	parent.restart_level()
	
func _on_JumpPlatformDetector_area_entered(area: Area2D) -> void:
	var vel_y = -jump_platf_impulse if not gravity_inverted else jump_platf_impulse
	velocity.y = vel_y
	flash_player()
	#print("Jumping in platform") 
	
func _on_PortalDetector_area_entered(area: Area2D) -> void:
	print("Player entro al area del portal")
	#velocity = velocity / portal_reduction_of_vel
	#gravity_inverted = not gravity_inverted
	#gravity_inverted = true

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: bool
	if not gravity_inverted:
		is_jump_interrupted = Input.is_action_just_released("jump") and velocity.y < 0.0
	else:
		is_jump_interrupted = Input.is_action_just_released("jump") and velocity.y > 0.0
		
	velocity = calculate_velocity(delta, velocity, is_jump_interrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

func _get_direction_y() -> float:
	if not gravity_inverted:
		return -1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	return 1.0 if Input.is_action_just_pressed("jump") and is_on_ceiling() else -1.0
	
func _process(_delta):
	if Input.is_key_pressed(KEY_X):
		$AnimationPlayer.play("Giro")
	
	if get_slide_count() == 2:
		restart_level()

func calculate_velocity(delta: float, previous_velocity: Vector2, is_jump_interrupted: bool) -> Vector2:
	if (gravity_inverted and gravity > 0) or (not gravity_inverted and gravity < 0): 
		gravity *= -1
	
	var new_velocity: = previous_velocity
	new_velocity.x += (speed.x * delta)
	new_velocity.y += (gravity * delta)
	
	var direction_y: = _get_direction_y()
	if (not gravity_inverted and direction_y == -1.0) or (gravity_inverted and direction_y == 1.0):
		new_velocity.y = speed.y * direction_y
		#print("entramo")
	if is_jump_interrupted:
		new_velocity.y = 0.0
		
	new_velocity.x = min(new_velocity.x, speed.x)
	
	# Applying boost
	new_velocity.x += boost
	
	return new_velocity

func increase_boost():
	boost += 30

# Funci??n para incrementar el score del jugador.
# TODO: tal vez esto tenga que ir a un script especial que maneje los puntos.
func increase_score():
	old_score = score
	score += 1
	var parent = get_parent()
	parent.update_score()

func _on_SlowdownDetector_area_entered(area: Area2D) -> void:
	print("slowdown")

func decrease_boost():
	boost -= 80
	
func reset_boost():
	boost = 0

func set_boost_level(boost_level: int):
	boost = boost_level * 10

func flash_player():
	$character.material.set_shader_param("player_color_modifier", 1)
	$FlashTimer.start()


func _on_FlashTimer_timeout():
	$character.material.set_shader_param("player_color_modifier", 0)

func toggle_gravity():
	gravity_inverted = not gravity_inverted
