# Script for collectible items and powerups inventory for the entire game.
# This script uses a GoDot singleton to hold, update, and maintain global data
# that is accessible from any scene or script in the entire game.

# Inventory is implemented with a dictionary object and items are defined by string names.
# Current inventory items:
#      "Key"

extends Node

# Singleton instance
var instance = null

# Dictionary to store inventory items
var inventory = {}

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

func get_inventory():
	return inventory


