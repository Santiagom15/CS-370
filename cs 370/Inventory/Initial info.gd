extends Node2D

# Get nodes for Speech, including speech bubble and text nodes
@onready var speech = get_node("Speech")
@onready var speechBubble = speech.get_node("Speech bubble")
@onready var speechText = speech.get_node("Speech text")

func _ready():
	speechBubble.z_index = 2
	speechText.z_index = 2

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		speechBubble.hide()
		speechText.hide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		speechBubble.show()
		speechText.show()
