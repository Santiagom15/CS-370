extends AudioStreamPlayer2D

func _ready():
	play()


func _process(delta):
	var time = get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency.
	time -= AudioServer.get_output_latency()
	print("Time is: ", time)
