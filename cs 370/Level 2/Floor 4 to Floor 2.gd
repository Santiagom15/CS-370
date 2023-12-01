extends CharacterBody2D
# Detect when the player has reached the end of the stairs in Level 1
# and automatically change scenes to Level 2

@onready var inventory = get_node("/root/Inventory")

# Detect when the player comes into/collides with the "Player detection"
# collision shape
func _on_player_detection_body_entered(body):
#	# Check if the body/node that has collided with Player decection
#	#  shape is named "Player"
	if body.name == "Player":
		# Change the scene to the next floor
		inventory.update_current_level("res://Level 3/Floor 2.tscn")
		inventory.update_transport(false)
		inventory.clear_level_items()
		inventory.clear_level_unlocks()
		get_tree().change_scene_to_file("res://Level 3/Floor 2.tscn")
