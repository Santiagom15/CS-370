# Place the player in the correct position and update level position
extends Node2D

@onready var inventory = get_node("/root/Inventory")
@onready var player = $Player 

@onready var collectible_items = get_node("Collectible items")
@onready var interactable_objects = get_node("Locked interactable objects")

signal itemDisabled(itemIdx)
signal lockDisabled(lockIdx)

var trans = false

# If the player was prematurely moved from current scene, place them where they were previously
func _ready():
	
	if inventory.get_transport():
		player.global_position = inventory.get_player_position()
		print("--- level re-entered: transport")
		print("    player.global_position: ", player.global_position)
		print("    inventory.get_player_position(): ", inventory.get_player_position())
		trans = true
		
	print("get_level_items(): ", inventory.get_level_items())
	for unlocked_item in inventory.get_level_items():
		itemDisabled.emit(unlocked_item)
		
	print("get_unlocks(): ", inventory.get_unlocks())
	print("get_inventory(): ", inventory.get_inventory())
	for unlocked_item in inventory.get_unlocks():
		lockDisabled.emit(unlocked_item)



# Update the player's position in the game data
func _process(delta):
	inventory.update_player_position(player.global_position)
	print("player.global_position: ", player.global_position)
	print("inventory.get_player_position(): ", inventory.get_player_position())
	if trans == true: 
		print("--- transported")
		print("-------")
		trans = false
