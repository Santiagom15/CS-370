# Script for collectible items and powerups inventory for the entire game.
# This script uses a GoDot singleton to hold, update, and maintain global data
# that is accessible from any scene or script in the entire game.

# Inventory is implemented with a dictionary object and items are defined by string names.
# Current inventory items:
#      "Key"

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

# Boolean array with flag: true if player entering current scene from boss battle, else otherwise
#						   true if player won the boss battle they are entering from, false otherwise
var bossBattleToLevel = [false, false]

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

# Set entering from a boss battle to true, retain current win status
func set_entering_from_boss_battle_true():
	bossBattleToLevel = [true, bossBattleToLevel[1]]

# Set entering from a boss battle to false, retain current win status
func set_entering_from_boss_battle_false():
	bossBattleToLevel = [false, bossBattleToLevel[1]]

# Set boss battle win status to true
func set_boss_battle_win():
	bossBattleToLevel = [bossBattleToLevel[0], true]

# Set boss battle win status to false
func set_boss_battle_loss():
	bossBattleToLevel = [bossBattleToLevel[0], false]

# Return entered from boss battle and boss battle win status
func get_boss_battle_status():
	return bossBattleToLevel



