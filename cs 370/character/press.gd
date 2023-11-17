extends Node2D

@onready var heart = $Heart
var heartRate = 0.5
var heartRateChaneg = 0.1
var stateofObject = false
#var isOnRigtFrame = 1==heartAni.get_frame()





# Called when the node enters the scene tree for the first time.
func _ready():
	pass# Replace with function body.

func ontime()->bool:
		return heart.get_frame() == 1
	
	#heart.play("heartBeat",heartbeat)
	#print(heart.get_playing_speed())
	##if moving and isFrame and space:
		#heart.play("heartBeat",heartbeat)
		#heartbeat = 1.0
	#elif moving and not isFrame and space:
	#	heart.play("heartBeat",heartbeat)
	##	heartbeat -= 0.1
	#elif moving and isFrame and not space:
	##else:
		#heart.play("heartBeat",heartbeat)
		#if accuracy < 0.5:
		#	heartbeat += 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
