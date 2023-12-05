extends Node2D

# Retrieve the game wide inventory, used to store data between scenes
@onready var inventory = get_node("/root/Inventory")
@onready var prev_interactions = inventory.get_interactions().duplicate()
@onready var curr_interactions = {}

@onready var player = $Player 

@onready var collectible_items = get_node("Collectible items")
@onready var interactable_objects = get_node("Locked interactable objects")

signal itemDisabled(itemIdx)
signal lockDisabled(lockIdx)

func _ready():
	inventory.update_current_level("res://Level 2/Floor 4.tscn")
	
	if inventory.get_transport():
		player.global_position = inventory.get_player_position()
		
	for unlocked_item in inventory.get_level_items():
		itemDisabled.emit(unlocked_item)
		
	for unlocked_item in inventory.get_unlocks():
		lockDisabled.emit(unlocked_item)
	
	if inventory.get_level_number_unlocked() < 2:
		inventory.update_level_number_unlocked(2)


# Update the player's position in the game data
func _process(delta):
	inventory.update_player_position(player.global_position)
