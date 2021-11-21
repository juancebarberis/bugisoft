extends Node2D

const USER_DATA_PATH = "user://fiubatrydash_user.data"

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
	_set_nickname_on_user_data()
	hide()
	parent.show_main_menu_screen()
	
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
	var parent = get_parent()
	file.open(USER_DATA_PATH, File.WRITE)
	file.store_line(parent.nickname)
