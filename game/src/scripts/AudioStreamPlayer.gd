extends AudioStreamPlayer

class_name Highscore_Song

var time_begin
var time_delay
const BPM = 110
const INITIAL_BEAT_TIME = 4.837

const IMPORTANT_BEATS = [
	4.837, # Initial beat. The level starts here
	26.638, # The song changes the mood (?)
	43.562, # A little scream announces the explosion
	44.106, # Explosion. We maybe should increase the speed here
	60.752, # The mood changes. Maybe adding some light effects would be great
	78.478, # Nice change of rhythm
	96.481, # The song "ends" for the level
]

func _ready() -> void:
	time_begin = OS.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	#$Player.play()


func _process(_delta: float) -> void:
	# Obtain from ticks.
	var time = (OS.get_ticks_usec() - time_begin) / 1000000.0
	# Compensate for latency.
	time -= time_delay
	# May be below 0 (did not begin yet).
	time = max(0, time)
