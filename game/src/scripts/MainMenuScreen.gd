extends Node2D

var mainLevel = preload("res://src/scenes/MainLevel.tscn").instance()

func _ready():
	visible = false


func _show():
	$NicknameLabel.text = "Hi, %s!" %get_parent().nickname
	show()


func _on_PlayGameButton_pressed():
	# frees the node. Starts main level
	var parent = get_parent()
	parent._stop_music()
	queue_free()
	parent.add_child(mainLevel)


func _on_ChangeNicknameButton_pressed() -> void:
	var parent = get_parent()
	hide()
	parent.show_set_nickname_screen()


func _on_ExitButton_pressed() -> void:
	get_tree().quit()


func _on_RankingsButton_pressed() -> void:
	var parent = get_parent()
	hide()
	parent.show_rankings_screen()
