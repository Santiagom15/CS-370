# Script for the instructions page
# Unlike other "pages" like the inventory, this scene will be instantiated through nodes
# in other scenes, and when the player presses the "Instructions"  button, the instance
# of the instructions page will be made visible. When the "Close" button in the instructions page
# is pressed, the page will be made non-visible again
extends Node2D

# Get the parent to all nodes for this scene 
@onready var instructionsPage = get_node("Instruction page all nodes")

# Get the parent node to all animations
@onready var anims = instructionsPage.get_node("Animation graphics")

func _ready():
	# Play all idle animations for each of the animation nodes in the scene
	for child_idx in range(anims.get_child_count()):
		var currAnim = anims.get_child(child_idx)
		currAnim.play("Idle")
		currAnim.set_frame(0)

# When "Close" button is pressed, make all nodes in this scene invisible
func _on_close_button_button_down():
	self.visible = false
