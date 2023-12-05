extends Node2D

@onready var detectItem : CollisionShape2D
@onready var colItem : CollisionPolygon2D
@onready var currItem : Node2D
@onready var num_children = get_child_count()

@onready var rng = RandomNumberGenerator.new()
var curr_rn : int

@onready var timer = get_parent().get_node("Random spawning collectible item")

var curr_item_idx : int

@onready var inventory = get_node("/root/Inventory")

func _ready():
	curr_item_idx = int(rng.randf_range(0, num_children-1))
	
	for child_idx in range(num_children):
		if child_idx != curr_item_idx:
			currItem = get_child(child_idx)
			currItem.hide()
			detectItem = currItem.get_child(0).get_node("PlayerDetectionItem").get_child(0)
			detectItem.set_deferred("disabled", true)
			colItem = currItem.get_child(0).get_node("CollisionPolygon2D")
			colItem.set_deferred("disabled", true)


func _on_random_spawning_collectible_item_timeout():
	curr_rn = int(rng.randf_range(0, num_children))
	if curr_rn == curr_item_idx: curr_rn += 1
	
	currItem = get_child(curr_rn)
	currItem.show()
	detectItem = currItem.get_child(0).get_node("PlayerDetectionItem").get_child(0)
	detectItem.set_deferred("disabled", false)
	colItem = currItem.get_child(0).get_node("CollisionPolygon2D")
	colItem.set_deferred("disabled", false)
	
	currItem = get_child(curr_item_idx)
	currItem.hide()
	detectItem = currItem.get_child(0).get_node("PlayerDetectionItem").get_child(0)
	detectItem.set_deferred("disabled", true)
	colItem = currItem.get_child(0).get_node("CollisionPolygon2D")
	colItem.set_deferred("disabled", true)
	
	curr_item_idx = curr_rn


func _process(delta):
	if inventory.get_level_items().size() > 0:
		timer.stop()
		currItem = get_child(curr_item_idx)
		currItem.hide()
		detectItem = currItem.get_child(0).get_node("PlayerDetectionItem").get_child(0)
		detectItem.set_deferred("disabled", true)
		colItem = currItem.get_child(0).get_node("CollisionPolygon2D")
		colItem.set_deferred("disabled", true)
