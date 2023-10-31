extends Node2D

@onready var item = $ItemTexture
@onready var inventory = get_node("/root/Inventory")

func _ready():
	
	# Code for testing inventory only
	# Randomly spawn items into the backend inventory to check their display in the frontend inventory
#	if randi() % 2 == 0:
#		inventory.add_item("Key")
#	else:
#		inventory.add_item("Blue")
	
	
	if inventory.has_item("Key"):
		item.texture = load("res://assets/Inventory/Key_yellow.png")
	#elif inventory.has_item("Blue"):
	else:
		item.texture = load("res://assets/Inventory/Key_blue.png")
