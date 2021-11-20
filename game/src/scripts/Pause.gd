extends Node


func _ready():
	# This explicitly sets our node under non-blocking process mode
	self.pause_mode = Node.PAUSE_MODE_PROCESS
	
func _process(delta: float) -> void:
	# Main loop. Check if the user wants to pause/resume the game.
	if not _is_paused() and Input.is_action_just_pressed("pause"):
		_pause_game()
	elif Input.is_action_just_pressed("pause"):
		_resume_game()

func _is_paused() -> bool:
	# Check if the game is paused
	return get_tree().paused

func _pause_game() -> void:
	# Show the pause UI and pause the tree
	get_parent().get_node("Canvas/UI/MainMenuButton").visible = true
	get_parent().get_node("Canvas/UI/MainTitle").visible = true
	get_parent().get_node("Canvas/UI/MainCredits").visible = true
	get_parent().get_node("Canvas/UI/BKGColor").visible = true
	get_parent().get_node("Canvas/UI/Pause").visible = true
	get_tree().paused = true
	
	
func _resume_game() -> void:
	# Hide the pause UI and resume the tree	
	get_parent().get_node("Canvas/UI/MainTitle").visible = false
	get_parent().get_node("Canvas/UI/MainCredits").visible = false
	get_parent().get_node("Canvas/UI/BKGColor").visible = false
	get_parent().get_node("Canvas/UI/Pause").visible = false
	get_parent().get_node("Canvas/UI/MainMenuButton").visible = false
	get_tree().paused = false



func _on_MainMenuButton_pressed():
	# unpauses tree and loads MainMenu scene
	get_tree().paused = false
	get_tree().change_scene("res://src/scenes/MainMenu.tscn")

