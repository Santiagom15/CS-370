# This script give functionality to the opening/closing vertical door.
# There is additional functionality where the a door rattle and key floating animation will play
# and the door will not open unless the player has the key collectible item when trying to open the door.
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

# Get the node for the inventory, which will have the key item data
@onready var inventory = get_node("/root/Inventory")

# Logical flag for if the door has been opened with the key yet (true) or not (false)
var unlocked = false
@onready var animKey = $AnimatedKey
@onready var animKeyFrames = animKey.get_sprite_frames()
@onready var total_num_key_frames = animKeyFrames.get_frame_count("Key")
@onready var animRattle = $AnimatedDoorRattle

@onready var levelRoot = get_parent().get_parent()
signal lockDisabled(lockIdx)
@onready var doorName = str(get_name())
var lockIdx : int

# As soon as scene loads, disable the collision shapes for when door is open 
func _ready():
	animKey.hide()
	collTopLeft.set_deferred("disabled", true)
	collTopRight.set_deferred("disabled", true)
	
	# Start all animations at initial frame
	animKey.set_frame(0)
	animRight.set_frame(0)
	animLeft.set_frame(0)
	animRattle.set_frame(0)
	
	levelRoot.lockDisabled.connect(_on_lock_disabled)
	

# When requirements are met, open the door to the correct side
func _process(delta):
	len = stack_approach_side.size()
	
	# Check if requirements are met and player has pressed the spacebar
	if play_open == true && len == 2 && Input.is_action_pressed("ui_accept"):
		
		# Case when play has the key or has already used the key
		if inventory.has_item("Key") == true || unlocked == true:
		
			# If the player still has the key, remove it from inventory and use it here
			if unlocked == false:
				unlocked = true
				inventory.remove_item("Key")
				
				# Update the list of locked interactable objects for the current level
				inventory.update_level_unlocks("Door" + doorName[-1])   # It is assumed that the name of any locked door node will end with a integer >= 0
																		# This is used to identify/distinguish the doors in the scene when unlocking/locking
				
			
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
		
		# Play door rattle and key floating animation when player tries to open door without having the key
		elif !animKey.is_playing():
			animKey.show()
			animKey.z_index = 1
			animKey.play("Key")
			animRattle.play("DoorRattle")


func _on_lock_disabled(lockIdx):
	# It is assumed that locked door node names will end in a int > 0 to identify/distinguish all locked doors in a scene
	if lockIdx == "Door" + doorName[-1]:
		unlocked = true


func _on_animated_key_frame_changed():
	# As animation plays, increase transparency of current frame to create a fading away visual affect
	animKey.modulate.a = 1.0 - (animKey.get_frame() / float(total_num_key_frames - 1))
	
	# When on the last frame, reset the animation to hidden and fully non-transparent
	if animKey.get_frame() == total_num_key_frames-1:
		animKey.hide()
		animKey.modulate.a = 1
		#has_key = true


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
