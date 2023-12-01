extends CharacterBody2D

# GoDot note: @onready means this line is called when the scene loads and only then
# Retrieve the animated door and character body Player nodes
@onready var anim = get_node("AnimatedSlideDoor")
@onready var player = get_parent().get_parent().get_node("player")

# Value of 0 mean no collision boxes for this door have been entered
# Value of 1 means either PlayerDetectionAnimCloseTop or PlayerDetectionAnimCloseBottom has been entered
# Used for initializing which side of the door player starts on
var FIRST_CHECK = 0

# Logical flags to play open or closed animations
var play_open = false
var play_close = false

# Logical flags indicating whether player is behind (top) or in-front (bottom) of door
# These are only both true when player is in the doorway
var in_top = false
var in_bottom = false

# Declare variable for current (only non-disabled) collision box for sliding door
var curr_coll : CollisionShape2D

var use_coll1 = true   # True when we want to use CollDoor1 child collision nodes, false when using CollDoor2 child collisions
var switch_anims = false   # True then we just switched from CollDoor1 -> CollDoor2 collisions or vice verse, false otherwise
var door_name : String 

# The current and previous frame index of the playing or played animation
var curr_frame = 0
var prev_frame = 0

# Get the node for the inventory, which will have the key item data
@onready var inventory = get_node("/root/Inventory")

# Logical flag for if the door has been opened with the key yet (true) or not (false)
var unlocked = false
@onready var animLock = $AnimatedLock
@onready var animLockFrames = animLock.get_sprite_frames()
@onready var total_num_key_frames = animLockFrames.get_frame_count("Bolt")


@onready var animRattle = $AnimatedDoorRattle
@onready var animLockOpen = $AnimatedLockOpen
@onready var animBoltCut = $AnimatedBoltCutterOpen


# As soon as scene loads, disable the collision shapes for when door is open 
func _ready():
	anim.z_index = 2
	animLock.z_index = 2
	animRattle.z_index = 2
	animLockOpen.z_index = 2
	animBoltCut.z_index = 2
	
	# Start all animations at initial frame
	animLock.set_frame(0)
	anim.set_frame(0)
	animRattle.set_frame(0)
	animLockOpen.set_frame(0)
	animBoltCut.set_frame(0)
	
	animLock.show()
	anim.hide()
	animRattle.show()
	animLockOpen.hide()
	animBoltCut.hide()


# GoDot note: the _process function is called every frame as soon as the scene has loaded
# Play the open door animation when requirements met
func _process(delta):
	
	# Check if requirements to open door are met and if player presses spacebar
	if play_open == true && Input.is_action_pressed("ui_accept"):
		
		# Case when play has the key or has already used the key
		if inventory.has_item("BoltCutter") == true || unlocked == true:
		
			# If the player still has the key, remove it from inventory and use it here
			if unlocked == false:
				unlocked = true
				inventory.remove_item("BoltCutter")
				
				animLock.hide()
				anim.show()
				animRattle.hide()
				animLockOpen.show()
				animBoltCut.show()
				
				animLockOpen.play("LockOpen")
				animBoltCut.play("BoltCutter")
				
				play_open = false
			
			else:
				play_open = false
				play_close = true
				
				# If the close animation is playing, start the open animation from the current frame
				if anim.is_playing():
					curr_frame = anim.get_frame()
				else:   # If close animation isn't playing, start open animation from start
					curr_frame = 0
				anim.play("SlideOpen")   # Play open animation
				anim.set_frame(curr_frame)
			
		elif !animLock.is_playing():
			play_open = false
			
			animLock.show()
			animRattle.show()
			animLock.play("Bolt")
			animRattle.play("DoorRattle")


func _on_animated_lock_open_animation_finished():
	animLockOpen.hide()
	animBoltCut.hide()
	
	play_close = true
		
	# If the close animation is playing, start the open animation from the current frame
	if anim.is_playing():
		curr_frame = anim.get_frame()
	else:   # If close animation isn't playing, start open animation from start
		curr_frame = 0
		anim.play("SlideOpen")   # Play open animation
		anim.set_frame(curr_frame)


# GoDot note: this signal function is called when a frame in the animation has changed to the next frame
# Enable/disable the appropriate collision shapes in correspondance to opening or closing door animation 
func _on_animated_slide_door_frame_changed():
	curr_frame = anim.get_frame()  # Get the current frame index

	if curr_frame % 2 == 0:   # Collision shapes 0,2,4,6 correspond to animation frames (0,1),(2,3),(4,5),(6,7) respectively

		# Note: There are $CollDoor1 and $CollDoor2 nodes. Both are a parent to a set of collision shape nodes which are identical besides their y-axis/height
		#       placement within the scene. CollDoor1 animations are for when the door is approached from above/behind, and CollDoor2 when approached from below/in-front.
		#       This allows the player to stand in-front or behind the door in realistic ways 
		
		if switch_anims:
			switch_anims = false
			if use_coll1: door_name = "2"
			else: door_name = "1"
		else:
			if use_coll1: door_name = "1"
			else: door_name = "2"

		# Disable collision on previous frame
		curr_coll = get_node(str("CollDoor", door_name, "/Coll", prev_frame, "a"))
		# Note: there are pairs of colision shapes (for example, $CollDoor1/Coll0a and $CollDoor1/Coll0a) for the right and left doors in the sliding door
		curr_coll.set_deferred("disabled", true)
		curr_coll = get_node(str("CollDoor", door_name, "/Coll", prev_frame, "b"))
		curr_coll.set_deferred("disabled", true)
		
		if use_coll1: door_name = "1"
		else: door_name = "2"

		# Enable collision on current frame
		curr_coll = get_node(str("CollDoor", door_name, "/Coll", curr_frame, "a"))
		curr_coll.set_deferred("disabled", false)
		curr_coll = get_node(str("CollDoor", door_name, "/Coll", curr_frame, "b"))
		curr_coll.set_deferred("disabled", false)

		# Update the previous frame index
		prev_frame = curr_frame


# Set play_open to true if the door is currently closed and player is close enough to door
func _on_PlayerDetectionAnimation_body_entered(body):
	if body.name == "player":
		if !play_close: play_open = true


# Set in_top to true when player is in the top collision area
func _on_PlayerDetectAnimCloseTop_body_entered(body):
	if body.name == "player":
		in_top = true
		
		# Initialize all collision shapes accordingly when player's first approach of the door is from behind/above
		if FIRST_CHECK == 0:
			# Disable collision on all CollDoor1 child nodes, except for the closed door collision shapes
			for i in range(2,7,2):
				curr_coll = get_node(str("CollDoor1/Coll", i, "a"))
				curr_coll.set_deferred("disabled", true)
				curr_coll = get_node(str("CollDoor1/Coll", i, "b"))
				curr_coll.set_deferred("disabled", true)
			# Disable collision on all CollDoor2 child nodes
			for i in range(0,7,2):
				curr_coll = get_node(str("CollDoor2/Coll", i, "a"))
				curr_coll.set_deferred("disabled", true)
				curr_coll = get_node(str("CollDoor2/Coll", i, "b"))
				curr_coll.set_deferred("disabled", true)
			
			use_coll1 = true
			FIRST_CHECK = 1


# Play door closing animation when requirements are met
func _on_PlayerDetectionAnimCloseTop_body_exited(body):
	if body.name == "player":
		if play_close && !in_bottom:   # If door open animation is playing or finished and player is only in top collision area
			# Play the animation from the correct frame
			if anim.is_playing():
				curr_frame = anim.get_frame()
			else: 
				curr_frame = 7
			anim.play_backwards("SlideOpen")  # Play the animation backwards to play the closing animation
			anim.set_frame(curr_frame)
			use_coll1 = true
			play_close = false
			switch_anims = true
		elif !in_bottom:
			play_open = false
		in_top = false   # Since player has exited the top area, set to false


# Set in_bottom to true when player is in the bottom collision area
func _on_PlayerDetectAnimCloseBottom_body_entered(body):
	if body.name == "player":
		in_bottom = true

		# Initialize all collision shapes accordingly when player's first approach of the door is from in-front/behind
		if FIRST_CHECK == 0:
			# Disable collision on all CollDoor1 child nodes
			for i in range(0,7,2):
				curr_coll = get_node(str("CollDoor1/Coll", i, "a"))
				curr_coll.set_deferred("disabled", true)
				curr_coll = get_node(str("CollDoor1/Coll", i, "b"))
				curr_coll.set_deferred("disabled", true)
			# Disable collision on all CollDoor2 child nodes, except for the closed door collision shapes
			for i in range(2,7,2):
				curr_coll = get_node(str("CollDoor2/Coll", i, "a"))
				curr_coll.set_deferred("disabled", true)
				curr_coll = get_node(str("CollDoor2/Coll", i, "b"))
				curr_coll.set_deferred("disabled", true)
			
			use_coll1 = false
			FIRST_CHECK = 1


# Play door closing animation when requirements are met
func _on_PlayerDetectAnimCloseBottom_body_exited(body):
	if body.name == "player":
		if play_close && !in_top:
			if anim.is_playing():
				curr_frame = anim.get_frame()
			else: 
				curr_frame = 7
			anim.play_backwards("SlideOpen")
			anim.set_frame(curr_frame)
			use_coll1 = false
			play_close = false
			switch_anims = true
		elif !in_top:
			play_open = false
		in_bottom = false
