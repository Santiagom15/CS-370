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
	
	var bossStatus = inventory.get_boss_battle_status()
	print("LevelData, bossStatus: ", bossStatus)
	
	if bossStatus[0]:
		player.global_position = Vector2(2412.31, 966.9786)
	elif inventory.get_transport():
		player.global_position = inventory.get_player_position()
		
	for unlocked_item in inventory.get_level_items():
		itemDisabled.emit(unlocked_item)
		
	for unlocked_item in inventory.get_unlocks():
		lockDisabled.emit(unlocked_item)



# Update the player's position in the game data
func _process(delta):
	inventory.update_player_position(player.global_position)
