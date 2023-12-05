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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
