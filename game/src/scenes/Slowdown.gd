extends Area2D
class_name Slowdown

#onready var player = get_node("Player")

#func _on_SlowdownDetector_body_entered(body: Node) -> void:

	#player.decrease_boost()

##Decreases boost

func _on_SlowdownDetector_body_entered(player: KinematicBody2D) -> void:
	player.decrease_boost()
	print("decrease boost")
