extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
var mainLevel = preload("res://src/scenes/MainLevel.tscn").instance()
var nickname

func _ready():
	$LineEdit.placeholder_text = "Write your nickname"
	pass

var current_menu : Node = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayGameButton_pressed():
	$PlayGameButton.queue_free()
	$NicknameLabel.queue_free()
	add_child(mainLevel)


func _on_OkButton_pressed():
	
	nickname = $LineEdit.get_text()
	$NicknameLabel.text = "HI %s" %nickname
	$LineEdit.queue_free()
	$OkButton.queue_free()
	$PlayGameButton.show()
	$NicknameLabel.show()
