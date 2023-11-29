extends Node2D

signal itemDisabled(itemIdx)
signal lockDisabled(lockIdx)

# Retrieve the game wide inventory, used to store data between scenes
@onready var inventory = get_node("/root/Inventory")
@onready var prev_interactions = inventory.get_interactions().duplicate()
@onready var curr_interactions = {}

func _ready():
	pass

func _process(delta):
	curr_interactions = inventory.get_interactions()
	if prev_interactions != curr_interactions:
		prev_interactions = curr_interactions.duplicate()
