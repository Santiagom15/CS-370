extends CharacterBody2D
# Detect when the player has reached the end of the stairs in Level 1
# and automatically change scenes to Level 2

## Detect when the player comes into/collides with the "Player detection"
## collision shape
func _on_player_detection_body_entered(body):
#	# Check if the body/node that has collided with Player decection
#	#  shape is named "Player"
	if body.name == "Player":
		# Change the scene to the next floor
		get_tree().change_scene_to_file("res://Level 3/Floor 2.tscn")
