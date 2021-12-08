extends Area2D

onready var animation = get_node("WaitingAnimation")
onready var light = get_node("PortalLight")
onready var portal_vibraiton_sound = get_node("PortalVibrationSound")
onready var portal_closing_sound = get_node("PortalClosingSound")

export var entered = false

func _ready() -> void:
	animation.play("waiting_for_entrance")
	portal_vibraiton_sound.play()

func _on_EntranceDetector_body_exited(body: Node) -> void:
	if not entered:
		body.toggle_gravity()
		entered = true
	close_portal()

func _on_PortalVibrationSound_finished() -> void:
	portal_vibraiton_sound.volume_db = 2.0
	portal_vibraiton_sound.play()

func close_portal() -> void:
	animation.play("disappearing")
	portal_vibraiton_sound.stop()
	
	portal_closing_sound.volume_db = 10.0
	portal_closing_sound.play()
	
	yield($WaitingAnimation, "animation_finished")
	queue_free()
	
