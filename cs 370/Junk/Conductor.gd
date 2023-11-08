extends AudioStreamPlayer2D

var time = 0;
func get_time():
	time = get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency.
	time -= AudioServer.get_output_latency()
