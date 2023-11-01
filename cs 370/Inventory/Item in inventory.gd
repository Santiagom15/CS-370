extends Node2D

@onready var item = $ItemTexture
@onready var anim = $ItemAnimation
@onready var inventory = get_node("/root/Inventory")

@onready var grid = get_parent().get_parent()
signal itemCurrent(item_id)

signal itemAnimPlay(item_id)

func _ready():
	
	anim.hide()
	
	grid.itemCurrent.connect(_on_item_current)
	grid.itemAnimPlay.connect(_on_item_anim_play)

func _on_item_current(item_id):
	print("Item in inventory slot: ", item_id)
	if item_id == "Key":
		print("    key")
		item.texture = load("res://assets/Inventory/Key_yellow.png")
	elif item_id == "Frog":
		print("    frog")
		item.texture = load("res://assets/Inventory/Frog_yellow.png")
	else:
		print("    null")
		item.texture = null


func _on_item_anim_play(item_id):
	anim.show()
	anim.play(item_id)
