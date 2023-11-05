# Script for collecting the "Key" item 
# This is an interactable animation but also a collectible item script. 
# When player enters the detection shape of the key, the key floating and sparkle
# animations play to completion and the "Key" item is added to the inventory (or its count is updated)
extends CharacterBody2D

var player_detected = false # True when player is currently in PlayerDetectionKey, false otherwise
var key_collected = false  # True when key has been collected, false otherwise

@onready var animKey = $AnimatedKey
@onready var animSparkle = $AnimatedSparkle
@onready var collision = $CollisionPolygon2D

# Retrieve the game collectible items inventory 
@onready var inventory = get_node("/root/Inventory")

# Signal for when key has been collected
signal keyCollected(keyIdx)
@onready var levelRoot = get_parent().get_parent().get_parent()
# Signal for when scene has been entered mid-level and key was previously collected 
signal keyDisabled(keyIdx)

@onready var keyName = str(get_parent().get_name())
var keyIdx_curr : int


func _ready():
	animKey.show()  # Show (enable visibility of) the Key node
	animKey.set_frame(0)  # Make the initial animation frame the first frame
	
	animSparkle.hide()   # Hide (disable visibility of) the sparkle animation
	animSparkle.set_frame(0)
	
	levelRoot.keyDisabled.connect(_on_key_disabled)


func _process(_delta):
	
	# Collect the key when player is in the key detection shape and presses the space bar
	if player_detected == true && key_collected == false && Input.is_action_pressed("ui_accept"):
		
		key_collected = true 
		
		# Play key floating and sparkle animations
		animSparkle.show()
		animKey.play("Key")
		animSparkle.play("Sparkle")
		collision.set_deferred("disabled", true)
		
		# Add the key to the game inventory so its count can be used elsewhere
		inventory.add_item("Key")
		
		# Emit signal for level script to retrieve to update collectible item data for scene
		keyIdx_curr = int(keyName[-1])
		keyCollected.emit(keyIdx_curr)


# Hide the key animation/node when the key floating animation has finished 
func _on_animated_sparkle_animation_finished():
	animSparkle.hide()


# Hide the sparkle animation/node when the sparkle animation is finished
func _on_animated_key_animation_finished():
	animKey.hide()


# Update detection flag to true when player has entered the key detection shape 
func _on_player_detection_key_body_entered(body):
	if body.name == "Player":
		player_detected = true


# Update detection flag to false when player has exited the key detection shape 
func _on_player_detection_key_body_exited(body):
	if body.name == "Player":
		player_detected = false


# Disable the collection of the key since it was previously collected in this level
func _on_key_disabled(keyIdx):
	if keyIdx == int(keyName[-1]):
		key_collected = true
		animKey.hide()
		animSparkle.hide()
		collision.set_deferred("disabled", true)
