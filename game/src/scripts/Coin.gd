extends Area2D

onready var animation = get_node("AnimationPlayer")

# This function detects the collision with the Player
func _on_body_entered(player: KinematicBody2D) -> void:
	# Play the animation for the coin
	animation.play("coin_destroy")
	
	# Sumar un punto al contador
	player.increase_score()
