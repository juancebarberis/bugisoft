extends Player


func _physics_process(delta: float) -> void:
	#var new_direction = 1 if Input.get_action_strength("jump") else 0
	print("Tick")
	
	if Input.get_action_strength("jump") == 1:
		velocity += speed * Vector2(1, 20)
