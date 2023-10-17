extends CharacterBody2D

@onready var _animated_sprite = $AnimationPlayer
@onready var timmy = $AudioStreamPlayer2D

var bpm = 60	#bpm of music
var bps = bpm / 60.0	#convert to beats per second

func _process(_delta):
	
	$AudioStreamPlayer2D.get_time()
	var t = int(timmy.time)
	if(t < 8):
		if(t % 4 == 0):
			_animated_sprite.speed_scale = bps
			_animated_sprite.play("sword")
	else:
		_animated_sprite.speed_scale = bps * 2
		_animated_sprite.play("sword")
		
		
	
