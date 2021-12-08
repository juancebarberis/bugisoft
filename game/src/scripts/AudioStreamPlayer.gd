extends AudioStreamPlayer

class_name Highscore_Song

export var time = 0.0
var time_begin
var time_delay
const BPM = 110
const INITIAL_BEAT_TIME = 4.837

var next_important_beat = INITIAL_BEAT_TIME
var important_beats = [
	INITIAL_BEAT_TIME, # Initial beat. The level starts here
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
	# Obtain from ticks
	time = (OS.get_ticks_usec() - time_begin) / 1000000.0
	# Compensate for latency
	time -= time_delay
	# May be below 0 (did not begin yet)
	time = max(0, time)
	
	if should_check_for_the_moment():
		print("Check the moment " + String(time))
		check_for_the_moment()

func should_check_for_the_moment():
	if next_important_beat != null:
		return time >= next_important_beat
	return false
	
func check_for_the_moment():
	# This function is in charge of triggering the correct thing
	# for the current Song time.
	var parent = get_parent()
	var player = parent.get_player()
	
	# Scripting for the song!
	
	if time_between(important_beats[0], important_beats[1]):
		next_important_beat = important_beats[1]
		parent.show_game_ui()
	elif time_between(important_beats[1], important_beats[2]):
		next_important_beat = important_beats[2]
		player.set_boost_level(5)
		parent.chromatic_abb()
	elif time_between(important_beats[2], important_beats[3]):
		next_important_beat = important_beats[3]
		print(2,player.position)
		# Placeholder
	elif time_between(important_beats[3], important_beats[4]):
		next_important_beat = important_beats[4]
		player.set_boost_level(15)
		print(3,player.position)		
	elif time_between(important_beats[4], important_beats[5]):
		next_important_beat = important_beats[-1]
		player.set_boost_level(20)
		print(4,player.position)		
	elif time_between(important_beats[5], important_beats[6]):
		next_important_beat = null
		player.set_boost_level(10)
		print(5,player.position)		
	else:
		next_important_beat = null

func time_between(value_1, value_2):
	return value_1 <= time and value_2 >= time
