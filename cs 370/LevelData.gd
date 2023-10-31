# Place the player in the correct position and update level position
extends Node2D

@onready var inventory = get_node("/root/Inventory")
@onready var key_scene = $"Collectible item key"
@onready var key = key_scene.get_child(0)
@onready var player = $Player 

signal keyCollected

# If the player was prematurely moved from current scene, place them where they were previously
func _ready():
	
	if inventory.get_transport():
		player.global_position = inventory.get_player_position()
		
	# Connect the signal emitted from key node to function in this script
	key.keyCollected.connect(_on_key_collected)
	
	if inventory.has_level_item("Key"):
		key_scene.set_deferred("visible", false)
		#key.visible = false

# Update the player's position in the game data
func _process(delta):
	inventory.update_player_position(player.global_position)

# When key is collected and keyCollected signal is emitted, update key data for file
func _on_key_collected():
	print("Key collected!")
	inventory.update_level_items("Key")
	

