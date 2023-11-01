# Place the player in the correct position and update level position
extends Node2D

@onready var inventory = get_node("/root/Inventory")
@onready var player = $Player 

@onready var key_scene = $"Collectible item key"
@onready var key = key_scene.get_child(0)
signal keyCollected
signal keyDisabled

signal frogDisabled

@onready var door = $"Animated door vertical nodes/Animated door vertical right locked"
signal doorUnlocked
signal doorLockDisabled

# If the player was prematurely moved from current scene, place them where they were previously
func _ready():
	
	if inventory.get_transport():
		player.global_position = inventory.get_player_position()
		
	# Connect the signal emitted from key node to function in this script
	key.keyCollected.connect(_on_key_collected)
	if inventory.has_level_item("Key"):
		print("LevelData keyDisbaled emitted")
		keyDisabled.emit()
	
	door.doorUnlocked.connect(_on_door_unlocked)
	if inventory.has_level_unlock("Door"):
		print("LevelData doorLockDisabled emitted")
		doorLockDisabled.emit()

# Update the player's position in the game data
func _process(delta):
	inventory.update_player_position(player.global_position)

# When key is collected and keyCollected signal is emitted, update key data for file
func _on_key_collected():
	print("Key collected!")
	inventory.update_level_items("Key")

# When door has already been opened and doorUnlocked signal emitted, update door to stay unlocked
func _on_door_unlocked():
	print("Door unlocked!")
	inventory.update_level_unlocks("Door")

