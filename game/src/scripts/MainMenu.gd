extends Node2D

export(String) var nickname

func _ready():
	nickname = $SetNicknameScreen._get_nickname_from_user_data()
	
	if nickname.length() > 0:
		show_main_menu_screen()
	else:
		show_set_nickname_screen()


func show_main_menu_screen():
		$MainMenuScreen._show()
		

func show_set_nickname_screen():
		$SetNicknameScreen._show()


func _on_MusicSwitch_toggled(button_pressed: bool) -> void:
	$BackgroundMusic.playing = button_pressed


func _stop_music():
	$BackgroundMusic.stop()
