extends Node2D

var mainLevel = preload("res://src/scenes/MainLevel.tscn").instance()
var nickname

func _ready():
	$LineEdit.placeholder_text = "Write your nickname"


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
