extends Area2D


func _on_Pinche_body_entered(player: KinematicBody2D):
	player.restart_level();
