extends KinematicBody2D
class_name Bullet

const FLOOR_NORMAL = Vector2.UP
export var bullet_velocity = Vector2(200,0)

func _ready() -> void:
	set_physics_process(false)
	bullet_velocity *= -1

func _physics_process(delta: float) -> void:
	if is_on_wall():
		queue_free()
	
	bullet_velocity = move_and_slide(bullet_velocity, FLOOR_NORMAL)
