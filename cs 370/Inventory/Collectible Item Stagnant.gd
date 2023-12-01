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

func _ready():
	animItem.show()  # Show (enable visibility of) the item animation
	animItem.set_frame(0)  # Make the initial animation frame the first frame
	animItem.play("Idle")
	
	animSparkle.hide()   # Hide (disable visibility of) the sparkle animation
	animSparkle.set_frame(0)


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


# Hide the sparkle animation/node when the sparkle animation has finished 
func _on_animated_sparkle_animation_finished():
	animSparkle.hide()


# Hide the item animation/node when the item collection animation is finished
func _on_animated_item_animation_finished():
	animItem.hide()


# Update detection flag to true when player has entered the item detection shape 
func _on_player_detection_item_body_entered(body):
	if body.name == "player":
		player_detected = true


# Update detection flag to false when player has exited the item detection shape 
func _on_player_detection_item_body_exited(body):
	if body.name == "player":
		player_detected = false
