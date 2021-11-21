extends Node2D

onready var file_system = preload("res://src/scripts/FileSystem.gd").new()

func _ready():
	# Initialize the screen
	visible = false
	
	# Sets placeholder for line edit
	$NicknameInput.placeholder_text = "Write your nickname"
	
	# By default, the button should be disabled
	$OkButton.disabled = true

func _show():
	var parent = get_parent()
	if parent.nickname.length() > 0:
		$NicknameInput.text = parent.nickname
		$OkButton.disabled = false
	show()


func _on_NicknameInput_text_entered(new_text: String) -> void:
	# If we press enter, is the same as clicking the OK button
	if new_text.length() > 0:
		_on_OkButton_pressed()

func _on_NicknameInput_text_changed(new_text: String) -> void:
	var parent = get_parent()
	parent.nickname = new_text
	$OkButton.disabled = parent.nickname.length() == 0


func _on_OkButton_pressed():
	# Gets nickname from label, frees Line edit and Ok button. Shows Play
	# game button and greeting
	var parent = get_parent()
	parent.nickname = $NicknameInput.get_text().to_upper()
	file_system.set_nickname_on_user_data(parent.nickname)
	hide()
	parent.show_main_menu_screen()

