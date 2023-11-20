# Script for collecting a item 
# This is an interactable animation but also a collectible item script. 
# When player enters the detection shape of the item, the item interaction and sparkle animations play
# to completion and the item is added to the inventory (or its count is updated) using its ITEM name (which
# will be the name of the node to which this script is attached). Additionally, the list of current collect items
# in a scene will also be updated upon collection, and when a level was prematurely exitted, the collection state of the object is preserved
extends CharacterBody2D

# Name of the item, for example "Key", "Frog", or "Candle"
@onready var ITEM = str(get_name())

var player_detected = false # True when player is currently in PlayerDetectionKey, false otherwise
var item_collected = false  # True when item has been collected, false otherwise
							# When item_collected = true, it can not be collected again, and it gets disabled

@onready var animItem = $AnimatedItem
@onready var animSparkle = $AnimatedSparkle
@onready var collision = $CollisionPolygon2D

# Retrieve the game collectible items inventory 
@onready var inventory = get_node("/root/Inventory")

@onready var levelRoot = get_parent().get_parent().get_parent()
# Signal for when scene has been entered mid-level and key was previously collected 
signal itemDisabled(itemIdx)
@onready var itemNameUnique = str(get_parent().get_name())  # Get the name of the node in level scene which insantiates the item class


func _ready():
	animItem.show()  # Show (enable visibility of) the item animation
	animItem.set_frame(0)  # Make the initial animation frame the first frame
	animItem.play("Idle")
	
	animSparkle.hide()   # Hide (disable visibility of) the sparkle animation
	animSparkle.set_frame(0)
	
	levelRoot.itemDisabled.connect(_on_item_disabled)


func _process(_delta):
	
	# Collect the item when player is in the item detection shape and presses the space bar
	if player_detected == true && item_collected == false && Input.is_action_pressed("ui_accept"):
		
		item_collected = true 
		
		# Play item collection/interaction and sparkle animations
		animSparkle.show()
		animItem.play(ITEM)
		animSparkle.play("Sparkle")
		collision.set_deferred("disabled", true)
		
		# Add the item to the game inventory so its count can be used elsewhere
		inventory.add_item(ITEM)

		# Update the inventory of the current level
		inventory.update_level_items(ITEM + itemNameUnique[-1])


# Hide the sparkle animation/node when the sparkle animation has finished 
func _on_animated_sparkle_animation_finished():
	animSparkle.hide()


# Hide the item animation/node when the item collection animation is finished
func _on_animated_item_animation_finished():
	animItem.hide()


# Update detection flag to true when player has entered the item detection shape 
func _on_player_detection_item_body_entered(body):
	if body.name == "Player":
		player_detected = true


# Update detection flag to false when player has exited the item detection shape 
func _on_player_detection_item_body_exited(body):
	if body.name == "Player":
		player_detected = false


# Disable the collection of the item since it was previously collected in this level
func _on_item_disabled(itemIdx):
	if itemIdx == str(ITEM + itemNameUnique[-1]):
		item_collected = true
		animItem.hide()
		animSparkle.hide()
		collision.set_deferred("disabled", true)

