# Script for collecting the "Frog" item 
# This is an interactable animation but also a collectible item script. 
# When player enters the detection shape of the frog, the frog floating and sparkle
# animations play to completion and the "Frog" item is added to the inventory (or its count is updated)
extends CharacterBody2D

var player_detected = false # True when player is currently in PlayerDetectionFrog, false otherwise
var frog_collected = false  # True when frog has been collected, false otherwise

@onready var animFrog = $AnimatedFrog
@onready var animSparkle = $AnimatedSparkle
@onready var collision = $CollisionPolygon2D

# Retrieve the game collectible items inventory 
@onready var inventory = get_node("/root/Inventory")

# Signal for when frog has been collected
signal frogCollected
@onready var levelRoot = get_parent().get_parent().get_parent()
# Signal for when scene has been entered mid-level and frog was previously collected 
signal frogDisabled


func _ready():
	animFrog.show()  # Show (enable visibility of) the Key node
	animFrog.set_frame(0)  # Make the initial animation frame the first frame
	
	animSparkle.hide()   # Hide (disable visibility of) the sparkle animation
	animSparkle.set_frame(0)
	
	levelRoot.frogDisabled.connect(_on_frog_disabled)


func _process(_delta):
	
	# Collect the frog when player is in the frog detection shape and presses the space bar
	if player_detected == true && frog_collected == false && Input.is_action_pressed("ui_accept"):
		
		frog_collected = true 
		
		# Play frog floating and sparkle animations
		animSparkle.show()
		animFrog.play("Frog")
		animSparkle.play("Sparkle")
		collision.set_deferred("disabled", true)
		
		# Add the frog to the game inventory so its count can be used elsewhere
		inventory.add_item("Frog")
		
		# Emit signal for level script to retrieve to update collectible item data for scene
		frogCollected.emit()


# Hide the frog animation/node when the frog floating animation has finished 
func _on_animated_sparkle_animation_finished():
	animSparkle.hide()


# Hide the sparkle animation/node when the sparkle animation is finished
func _on_animated_frog_animation_finished():
	animFrog.hide()


# Update detection flag to true when player has entered the frog detection shape 
func _on_player_detection_frog_body_entered(body):
	if body.name == "Player":
		player_detected = true

# Update detection flag to false when player has exited the frog detection shape 
func _on_player_detection_frog_body_exited(body):
	if body.name == "Player":
		player_detected = false

# Disable the collection of the frog since it was previously collected in this level
func _on_frog_disabled():
	frog_collected = true
	animFrog.hide()
	animSparkle.hide()
	collision.set_deferred("disabled", true)
