extends Node2D

var item : TextureRect

func _ready():
	item = $ItemTexture
	
	if randi() % 2 == 0:
		item.texture = load("res://assets/Inventory/Key_yellow.png")
	else:
		item.texture = load("res://assets/Inventory/Key_blue.png")
