extends CharacterBody2D
# Detect when the player has reached the end of the stairs in Level 1
# and automatically change scenes to Level 2

@onready var inventory = get_node("/root/Inventory")
@onready var player = get_parent().get_node("Player")
@onready var bossStatus = []

func _ready():
	bossStatus = inventory.get_boss_battle_status()
	print("Floor 5 to Boss ready, bossStatus: ", bossStatus)

	var detect = get_child(0).get_child(0)
	if bossStatus[1]:
		detect.set_deferred("disabled", true)
		inventory.set_entering_from_boss_battle_false()
#	else:
#		detect.set_deferred("disabled", false)
#		inventory.set_entering_from_boss_battle_false()

## Detect when the player comes into/collides with the "Player detection"
## collision shape
func _on_player_detection_body_entered(body):
#	# Check if the body/node that has collided with Player decection
#	#  shape is named "Player"
	bossStatus = inventory.get_boss_battle_status()
	if !bossStatus[0] && body.name == "Player":
		# Change the scene to the next floor
		get_tree().change_scene_to_file("res://Level 1/bossbattle_floor5.tscn")

