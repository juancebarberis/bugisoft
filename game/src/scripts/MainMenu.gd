extends Node2D

var mainLevel = preload("res://src/scenes/MainLevel.tscn").instance()
const USER_DATA_PATH = "user://fiubatrydash_user.data"
var nickname

func _ready():
	# Sets placeholder for line edit
	$NicknameInput.placeholder_text = "Write your nickname"
	
	# By default, the button should be disabled
	$OkButton.disabled = true
	
	nickname = _get_nickname_from_user_data()
	
	if nickname.length() > 0:
		_toggle_to_menu()


func _get_nickname_from_user_data():
	# Try to get the user's nickname saved on the FS
	# If the user doesn't register a nickname, we just return an empty string
	var file = File.new()
	var saved_nickname = ""
	
	if file.file_exists(USER_DATA_PATH):
		file.open(USER_DATA_PATH, File.READ)
		saved_nickname = file.get_as_text().strip_escapes()
		file.close()
	return saved_nickname
	
func _set_nickname_on_user_data():
	# Sets the new nickname on the FS
	var file = File.new()
	file.open(USER_DATA_PATH, File.WRITE)
	file.store_line(nickname)

func _on_PlayGameButton_pressed():
	# frees Play Button and Nickname. Starts main level
	$BackgroundMusic.stop()
	$PlayGameButton.queue_free()
	$NicknameLabel.queue_free()
	add_child(mainLevel)


func _on_OkButton_pressed():
	# Gets nickname from label, frees Line edit and Ok button. Shows Play
	# game button and greeting
	nickname = $NicknameInput.get_text().to_upper()
	_set_nickname_on_user_data()
	_toggle_to_menu()

func _toggle_to_menu():
	$NicknameLabel.text = "Hey %s!" %nickname
	$NicknameInput.queue_free()
	$OkButton.queue_free()
	$PlayGameButton.show()
	$NicknameLabel.show()

func _on_NicknameInput_text_entered(new_text: String) -> void:
	# If we press enter, is the same as clicking the OK button
	if new_text.length() > 0:
		_on_OkButton_pressed()


func _on_NicknameInput_text_changed(new_text: String) -> void:
	nickname = new_text
	$OkButton.disabled = nickname.length() == 0
