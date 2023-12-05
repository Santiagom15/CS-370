extends Node2D

# Get the node for the inventory, which will have the key item data
@onready var inventory = get_node("/root/Inventory")

func _ready():
	var animDoor = get_node("Animated glass sliding door 0")
	animDoor.z_index = 2

func _process(delta):
	if inventory.has_item("Key"):
		var blocking_collision = get_parent().get_node("Lane collision").get_node("Blocking 2")
		blocking_collision.set_deferred("disabled", true)
