extends Area2D

class_name Coin

onready var animation = get_node("AnimationPlayer")
onready var hit_sound = get_node("HitSound")
onready var hit_sound_audio = preload("res://src/audio/coin_2.wav")
onready var light = get_node("CoinLight")

var hit_sound_played = false

# This function detects the collision with the Player
func _on_body_entered(player: KinematicBody2D) -> void:
	# Play the animation for the coin
	animation.play("coin_destroy")
	light.hide()
	
	# Play the sound
	if not hit_sound_played:
		_play_hit_sound()
	
	player.increase_boost()
	
	# Sumar un punto al contador
	player.increase_score()
	
	
	
func _play_hit_sound():
	hit_sound.stream = hit_sound_audio
	hit_sound.volume_db = 1.0
	hit_sound.play()
	hit_sound_played = true
