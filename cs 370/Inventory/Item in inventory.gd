extends Node2D

@onready var item = $ItemTexture
@onready var inventory = get_node("/root/Inventory")

@onready var grid = get_parent().get_parent()
signal itemCurrent(item_id)

func _ready():
	
	# Code for testing inventory only
	# Randomly spawn items into the backend inventory to check their display in the frontend inventory
#	if randi() % 2 == 0:
#		inventory.add_item("Key")
#	else:
#		inventory.add_item("Blue")
	print("Grid:", grid)
	grid.itemCurrent.connect(_on_item_current)
	
#	if inventory.has_item("Key"):
#		item.texture = load("res://assets/Inventory/Key_yellow.png")
#	#elif inventory.has_item("Blue"):
#	else:
#		#item.texture = load("res://assets/Inventory/Key_blue.png")
#		item.texture = null

func _on_item_current(item_id):
	print("Item in inventory slot: ", item_id)
	if item_id == "Key":
		item.texture = load("res://assets/Inventory/Key_yellow.png")
	else:
		item.texture = null
