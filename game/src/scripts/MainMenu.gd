extends Node2D

var mainLevel = preload("res://src/scenes/MainLevel.tscn").instance()
var nickname

func _ready():
	# Sets placeholder for line edit
	$LineEdit.placeholder_text = "Write your nickname"


func _on_PlayGameButton_pressed():
	# frees Play Button and Nickname. Starts main level
	$PlayGameButton.queue_free()
	$NicknameLabel.queue_free()
	add_child(mainLevel)


func _on_OkButton_pressed():
	# Gets nickname from label, frees Line edit and Ok button. Shows Play
	# game button and greeting
	nickname = $LineEdit.get_text()
	$NicknameLabel.text = "HI %s" %nickname
	$LineEdit.queue_free()
	$OkButton.queue_free()
	$PlayGameButton.show()
	$NicknameLabel.show()
