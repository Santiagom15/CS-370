# Place the player in the correct position and update level position
extends Node2D

@onready var inventory = get_node("/root/Inventory")
@onready var player = $Player 

@onready var collectible_items = get_node("Collectible items")
@onready var interactable_objects = get_node("Locked interactable objects")

signal itemDisabled(itemIdx)
signal lockDisabled(lockIdx)


# If the player was prematurely moved from current scene, place them where they were previously
func _ready():
	inventory.update_current_level("res://Level 5/Floor 1.tscn")
	
	var bossStatus = inventory.get_boss_battle_status()
	
	if inventory.get_transport():
		player.global_position = inventory.get_player_position()
		
	for unlocked_item in inventory.get_level_items():
		itemDisabled.emit(unlocked_item)
		
	for unlocked_item in inventory.get_unlocks():
		lockDisabled.emit(unlocked_item)


# Update the player's position in the game data
func _process(delta):
	inventory.update_player_position(player.global_position)
