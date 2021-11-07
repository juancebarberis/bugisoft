extends Area2D

onready var animation = get_node("AnimationPlayer")

# Esta función detecta si el Player colisiona con la Coin
# Recibe el nodo del Player
func _on_body_entered(player: KinematicBody2D) -> void:
	# Reproducir animación para destruir Coin de la pantalla
	animation.play("coin_destroy")
	
	# Sumar un punto al contador
	player.increase_score()
