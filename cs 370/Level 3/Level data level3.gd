extends Node2D

# Retrieve the game wide inventory, used to store data between scenes
@onready var inventory = get_node("/root/Inventory")
@onready var prev_interactions = inventory.get_interactions().duplicate()
@onready var curr_interactions = {}

@onready var player = $Player 

@onready var interactable_objects = get_node("Locked interactable objects")

signal lockDisabled(lockIdx)

func _ready():
	inventory.update_current_level("res://Level 3/Floor 2.tscn")
	
	if inventory.get_transport():
		player.global_position = inventory.get_player_position()
		
	for unlocked_item in inventory.get_unlocks():
		lockDisabled.emit(unlocked_item)

# Update the player's position in the game data
func _process(delta):
	inventory.update_player_position(player.global_position)
