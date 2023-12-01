extends Node2D

var interaction_name = "initialInfo"

# Get nodes for Speech, including speech bubble and text nodes
@onready var speech = get_node("Speech")
@onready var speechBubble = speech.get_node("Speech bubble")
@onready var speechText = speech.get_node("Speech text")

@onready var detectCol = get_node("PlayerDetection").get_child(0)

# Retrieve the game wide inventory, used to store data between scenes
@onready var inventory = get_node("/root/Inventory")

func _ready():
	if inventory.get_interaction_state(interaction_name) == 0:
		speechBubble.z_index = 2
		speechText.z_index = 2
		speechBubble.show()
		speechText.show()
	else:
		speechBubble.hide()
		speechText.hide()
		detectCol.set_deferred("disabled", true)


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		speechBubble.hide()
		speechText.hide()
		detectCol.set_deferred("disabled", true)
		
		inventory.update_interaction(interaction_name)
