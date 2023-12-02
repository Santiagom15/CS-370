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
	
	var bossStatus = inventory.get_boss_battle_status()
	if bossStatus:
		var coffeeItem = get_node("Collectible items").get_node("Collectible item coffee 0")
		coffeeItem.visible = true
		var coffeeCol = coffeeItem.get_child(0).get_node("PlayerDetectionItem").get_child(0)
		coffeeCol.set_deferred("disabled", false)
	else:
		var coffeeItem = get_node("Collectible items").get_node("Collectible item coffee 0")
		coffeeItem.visible = false
		var coffeeCol = coffeeItem.get_child(0).get_node("PlayerDetectionItem").get_child(0)
		coffeeCol.set_deferred("disabled", true)
	
	if inventory.get_transport():
		player.global_position = inventory.get_player_position()
		
	for unlocked_item in inventory.get_level_items():
		itemDisabled.emit(unlocked_item)
		
	for unlocked_item in inventory.get_unlocks():
		lockDisabled.emit(unlocked_item)
	


# Update the player's position in the game data
func _process(delta):
	inventory.update_player_position(player.global_position)
