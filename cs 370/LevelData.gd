# Place the player in the correct position and update level position
extends Node2D

@onready var inventory = get_node("/root/Inventory")
@onready var player = $Player 

@onready var collectible_items = get_node("Collectible items")
var curr_item_node = null
@onready var interactable_objects = get_node("Locked interactable objects")
var curr_interaction_node = null
signal keyCollected(keyIdx)
signal keyDisabled(keyIdx)

signal frogDisabled

@onready var door = $"Animated door vertical nodes/Animated door vertical right locked"
signal doorUnlocked(doorIdx)
signal doorLockDisabled(doorIdx)
var curr_item : int

# If the player was prematurely moved from current scene, place them where they were previously
func _ready():
	
	if inventory.get_transport():
		player.global_position = inventory.get_player_position()
		
	# Connect the signal emitted from key node to function in this script
	for idx in range(collectible_items.get_child_count(false)):
		curr_item_node = collectible_items.get_child(idx).get_child(0)
		if "Key" in curr_item_node.get_name() || "key" in curr_item_node.get_name():
			curr_item_node.keyCollected.connect(_on_key_collected)
			
	print("get_level_items(): ", inventory.get_level_items())
	for unlocked_item in inventory.get_level_items():
		if "Key" in unlocked_item:
			curr_item = int(unlocked_item[-1])
			keyDisabled.emit(curr_item)
	
	
	for idx in range(interactable_objects.get_child_count(false)):
		curr_interaction_node = interactable_objects.get_child(idx)
		if "Door" in curr_interaction_node.get_name() || "door" in curr_interaction_node.get_name():
			curr_interaction_node.doorUnlocked.connect(_on_door_unlocked)
	
	print("get_unlocks(): ", inventory.get_unlocks())
	print("get_inventory(): ", inventory.get_inventory())
	for unlocked_item in inventory.get_unlocks():
		if "Door" in unlocked_item:
			curr_item = int(unlocked_item[-1])
			doorLockDisabled.emit(curr_item)



# Update the player's position in the game data
func _process(delta):
	inventory.update_player_position(player.global_position)

# When key is collected and keyCollected signal is emitted, update key data for file
func _on_key_collected(keyIdx):
	inventory.update_level_items("Key" + str(keyIdx))

# When door has already been opened and doorUnlocked signal emitted, update door to stay unlocked
func _on_door_unlocked(doorIdx):
	inventory.update_level_unlocks("Door" + str(doorIdx))
