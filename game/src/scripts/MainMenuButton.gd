extends Button


func _ready():
	# can fire signals while paused
	self.pause_mode = PAUSE_MODE_PROCESS
