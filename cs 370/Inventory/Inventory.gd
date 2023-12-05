# Script for collectible items and powerups inventory for the entire game.
# This script uses a GoDot singleton to hold, update, and maintain global data
# that is accessible from any scene or script in the entire game.

# Inventory is implemented with a dictionary object and items are defined by string names.
# Current inventory items:
#   "Key"
#	"Frog"
#	"Candle"
#	"Hat"
#	"BoltCutter"
#	"Brain"
#	"Coffee"
#	"Flower"
#	"Money"

# Additionally, inventory singleton stores a string containing the path of the current level scene
# or previous level if player is in a non-level scene (like home or inventory page).


extends Node

# Singleton instance
var instance = null

# Dictionary to store inventory items
var inventory = {}

# Directory/path of the current level scene (used when returning to level from inventory)
var currLevel = ""

# Current/previous position of the player in a level scene
var playerPosition: Vector2 = Vector2()
# Check if a level has been left prematurely (like entering inventory) 
var transport = false

# Array of strings tracking specific items collected in current scene
var levelItems = []

# Array storing the item_id of unlocked interactible items in current scene
var levelUnlocks = []

# Logical flag for if player won the boss battle for current level, true if player won the boss battle they are entering from, false otherwise
var bossBattleWinStatus = false

# Dictionary storing the state of all major collectible or NPC based interactions in the current scene
# 	key: name of the interaction (ex. "Room 1")
#	value: an integer >= 0 that represents the state of the interaction
var interactionStates = {}

# Store the previous page scene. This includes menu page, level navigation, and exploration scenes, but does not include instructions page, start page, or boss battle scenes
var prevPage = ""

# Store the number of the highest level unlocked/reached
var highestLevelUnlocked = 1

# Function to get the singleton instance
func _get_instance():
	if instance == null:
		instance = preload("res://Inventory/Inventory.gd").new()
	return instance

# Function to add an item to the inventory
func add_item(item_id, count = 1):
	if inventory.has(item_id):
		inventory[item_id] += count
	else:
		inventory[item_id] = count

# Function to remove an item from the inventory
func remove_item(item_id, count = 1):
	if inventory.has(item_id):
		inventory[item_id] -= count
		if inventory[item_id] <= 0:
			inventory.erase(item_id)

# Function to check if an item is in the inventory
func has_item(item_id):
	return inventory.has(item_id)

# Function to get the count of an item in the inventory
func get_item_count(item_id):
	return inventory.get(item_id, 0)

# Function to return the dictionary of items and counts
func get_inventory():
	return inventory

# Function to clear all items in the inventory
func clear_inventory():
	inventory = {}

# Function to update the path of the current level (or previous level, if player is in inventory)
func update_current_level(curr_path):
	currLevel = curr_path

# Function to return the path of the current level (or previous level, if player is in inventory)
func get_current_level():
	return currLevel

# Function to set the player's position
func update_player_position(position: Vector2):
	playerPosition = position
	update_transport(true)

# Function to get the player's position
func get_player_position() -> Vector2:
	return playerPosition

# Update transport
func update_transport(inBool):
	transport = inBool

# Get transport
func get_transport():
	return transport

# Add item to the list of current items in the level
func update_level_items(item_id):
	levelItems.append(item_id)

# Check if an item is in the list of current items in the level
func has_level_item(item_id):
	if item_id in levelItems: return true
	else: return false

# Return list of items in current level
func get_level_items():
	return levelItems

# Clear the level items list
func clear_level_items():
	levelItems = []

# Add item to list of unlocked object/interactions in the level
func update_level_unlocks(item_id):
	levelUnlocks.append(item_id)
	
# Check if an object/interaction is in the current level list
func has_level_unlock(item_id):
	if item_id in levelUnlocks: return true
	else: return false

# Return the list of unlocked items in current level
func get_unlocks():
	return levelUnlocks

# Clear the level items list
func clear_level_unlocks():
	levelUnlocks = []

# Set boss battle win status to input status
func set_boss_battle_status(status):
	bossBattleWinStatus = status

# Return boss battle win status
func get_boss_battle_status():
	return bossBattleWinStatus

# Function to add an interaction to interactionStates or update/increase state of existing element
func update_interaction(item_id):
	if interactionStates.has(item_id):
		interactionStates[item_id] += 1
	else:
		interactionStates[item_id] = 0

# Function to set interaction state equal to input value
func set_interaction(item_id, state):
	interactionStates[item_id] = state

# Function to remove an interaction or decrease state for an interaction in interactionStates
func decrease_interaction(item_id):
	if interactionStates.has(item_id):
		interactionStates[item_id] -= 1
		if interactionStates[item_id] < 0:
			interactionStates.erase(item_id)

# Function to check if interactionStates is empty
func check_empty_interaction():
	return interactionStates.empty()

# Function to check if a certain interaction exists in interactionStates
func has_interaction(item_id):
	if item_id in interactionStates: return true
	else: return false 

# Function to get the state of an interaction in interactionStates
func get_interaction_state(item_id):
	return interactionStates.get(item_id, 0)

# Function to return the dictionary interactionStates of level interactions and counts
func get_interactions():
	return interactionStates

# Function to clear interactionStates
func clear_interactions():
	interactionStates = {}

# Function to clear all relevant information for the current level
# Used when transitioning between one scene to the next after completion, or switching between scenes in level navigiation scene
func clear_level_data():
	clear_inventory()
	update_transport(false)
	clear_level_items()
	clear_level_unlocks()
	set_boss_battle_status(false)
	clear_interactions()

# Set the path of the previous page (will be done on the current to be used by the inventory inorder to return to the correct page)
func set_prev_page(path):
	prevPage = path

# Get the previous page path
func get_prev_page():
	return prevPage

# Get the number of the highest level currently unlocked
func get_level_number_unlocked():
	return highestLevelUnlocked

# Update the number of the highest level unlocked
func update_level_number_unlocked(level_idx):
	highestLevelUnlocked = level_idx
