# This script give functionality to the opening/closing vertical door.
# This is an interactable animation. The door opens when the player presses the spacebar
# when close enough, and the player can walk through. When the door is approached by the
# player from the left, the door opens to the right, and when approached from the right the
# door opens to the left. The door automatically closes (in the same direction it was openned in)
# when the player has walked far enough away.

extends CharacterBody2D

# Get the node of the collision shape for the closed door
@onready var collDoor = $CollDoor
# Get the collision shapes for approaching the door (they won't collide with the player, but act as detection areas)
@onready var detectLeft = $PlayerDetectionFromLeft/CollisionShape2D
@onready var detectRight = $PlayerDetectionFromRight/CollisionShape2D
# Get the animation nodes for when door opens/closes to the right or left
@onready var animRight = $AnimatedDoorRight
@onready var animLeft = $AnimatedDoorLeft
# Get the collision shapes which are enabled when respective right or left door is opened
@onready var collTopLeft = $CollTopDoorLeft
@onready var collTopRight = $CollTopDoorRight

# Logical variables recording the state of the door
var play_open = false   # True when requirements are met to open door and door hasn't yet been opened
var play_close = false  # True when door has just been opened and player has moved far enough away from door
var left_open = false   # True when door is open to the right (when player has approached from the left)
var right_open = false  # True when door is open to the left (when player has approached from the right)

# Stack to record current and recent position(s) of player relative to door.
# Value of 0 means player is to the left of the door, 1 means to the right
var stack_approach_side : Array = []
var len : int   # Used to track length of the stack
var curr_side : int   # Used to store top of stack (current side player is on)


# As soon as scene loads, disable the collision shapes for when door is open 
func _ready():
	collTopLeft.set_deferred("disabled", true)
	collTopRight.set_deferred("disabled", true)
 

# When requirements are met, open the door to the correct side
func _process(delta):
	len = stack_approach_side.size()
	
	# Check if requirements are met and player has pressed the spacebar
	if play_open == true && len == 2 && Input.is_action_pressed("ui_accept"):
		curr_side = stack_approach_side[len - 1]  # Get current side of the door the player is on
		
		# If player is to the left, open the door to the right
		if curr_side == 0 && right_open == false:
			# Play open right animation
			animRight.play("OpenRight")
			# Disable/enable correct collision shapes
			collDoor.set_deferred("disabled", true)  # Disable the vertical door collision shape so the player can walk through doorway
			collTopRight.set_deferred("disabled", false)   # Enable the top of open door collision shape so player can't walk over door 
			# Update state flags
			play_open = false
			play_close = true
			left_open = true
			
		# If player is to the right, open the door to the left
		elif curr_side == 1 && left_open == false:
			animLeft.play("OpenLeft")
			collDoor.set_deferred("disabled", true)  # Disable the CollisionShape2D
			collTopLeft.set_deferred("disabled", false)
			play_open = false
			play_close = true
			right_open = true


# Update door state when player enters the left detection shape
func _on_PlayerDetectionFromLeft_body_entered(body):
	if body.name == "Player":  # Check if the colliding body is the player
		# If door is currently closed, set play_open to true
		if !play_close: 
			play_open = true
		
		# This is the tricky case when: if the door is currently open and the player is standing in the doorway
		# in the opposite detection space than they opened the door from but they have not moved far enough away to close the door.
		# Thus, update player position relative to the door by inserting at front of stack
		if right_open: 
			stack_approach_side.insert(0,0)
		# Typical case, update play position state by inserting at end of stack
		else:
			stack_approach_side.append(0)


# Update door state when player enters the left detection shape
func _on_PlayerDetectionFromRight_body_entered(body):
	if body.name == "Player":
		if !play_close:
			play_open = true
		if left_open: # Look at above function for additional comments on this tricky case
			stack_approach_side.insert(0,1)
		else:
			stack_approach_side.append(1)


# When requirements met, close the door and/or update door/player states
func _on_PlayerDetectionFromLeft_body_exited(body):
	if body.name == "Player":
		curr_side = stack_approach_side[stack_approach_side.size() - 1]
		
		# When player is leaving left detection space to no detection space, close door and update states normally
		if curr_side == 0:
			if play_close:
				collDoor.set_deferred("disabled", false)  # Enable the closed door collision shape
				collTopRight.set_deferred("disabled", true)   # Disable the open door collision shape
				animRight.play("CloseRight")   # Play animation for closing the door to the right
				play_close = false
				left_open = false
			stack_approach_side.pop_back() 
		# When player is exitting left detection space and entering right detection space
		elif curr_side == 1:
			stack_approach_side.pop_front()


# When requirements met, close the door and/or update door/player states
func _on_PlayerDetectionFromRight_body_exited(body):
	if body.name == "Player":
		curr_side = stack_approach_side[stack_approach_side.size() - 1]
		if curr_side == 1:
			if play_close:
				collDoor.set_deferred("disabled", false)
				collTopLeft.set_deferred("disabled", true)
				animLeft.play("CloseLeft")
				play_close = false
				right_open = false
			stack_approach_side.pop_back() 
		elif curr_side == 0:
			stack_approach_side.pop_front()
