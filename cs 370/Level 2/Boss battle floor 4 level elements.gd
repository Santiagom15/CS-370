extends Node2D

# Get the node for the inventory, which will have the key item data
@onready var inventory = get_node("/root/Inventory")

func _process(delta):
	if inventory.has_item("Coffee"):
		var blocking_collision = get_parent().get_node("Collision shapes").get_node("Wall and furniture collisions").get_node("Blocking door until item collected")
		blocking_collision.set_deferred("disabled", true)
