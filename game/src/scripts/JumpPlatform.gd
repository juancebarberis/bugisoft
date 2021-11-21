extends Area2D

class_name JumpTile

onready var animation = get_node("AnimatedSprite")
onready var jump_sound_audio = preload("res://src/audio/jumpsound.wav")
onready var jump_sound = get_node("JumpSound")
onready var light = get_node("JumpPlatformLight")
var jump_sound_played = false

func _ready() -> void:
	animation.play("effervescence")

func _on_JumpDetector_body_entered(body: Node) -> void:
	if not jump_sound_played:
		jump_sound_played = true
		_play_jump_sound()

func _play_jump_sound():
	jump_sound.stream = jump_sound_audio
	jump_sound.volume_db = 1.0
	jump_sound.play()
