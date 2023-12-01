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
	
	if bossStatus[0]:
		player.global_position = Vector2(2412.31, 966.9786)
	elif inventory.get_transport():
		player.global_position = inventory.get_player_position()
		
	for unlocked_item in inventory.get_level_items():
		itemDisabled.emit(unlocked_item)
		
	for unlocked_item in inventory.get_unlocks():
		lockDisabled.emit(unlocked_item)


func _process(delta):
	inventory.update_player_position(player.global_position)
	
	curr_interactions = inventory.get_interactions()
	if prev_interactions != curr_interactions:
		prev_interactions = curr_interactions.duplicate()
