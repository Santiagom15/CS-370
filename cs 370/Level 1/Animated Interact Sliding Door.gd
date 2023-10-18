extends CharacterBody2D

@onready var anim = get_node("AnimatedSlideDoor")
@onready var root = get_parent()
@onready var player = root.get_node("Player")
@onready var initialPlayerZIndex = player.z_index

var curr_coll : CollisionShape2D

# Value of 0 mean no collision boxes for this door have been entered
# Value of 1 means either PlayerDetectionAnimCloseTop or PlayerDetectionAnimCloseBottom has been entered
var FIRST_CHECK = 0

var play_open = false
var play_close = false

var in_top = false
var in_bottom = false

var use_coll1 = true
var door_name : String

# It is expected that the frames for the door closing and openning line up
# They are the same sprite frames, just in reverse order. Accordingly, they should have the same number of frames each
var curr_frame = 0
var prev_frame = 0

var playing_forward = true


func print_states(input_string: String):
	#print(input_string)
	#print("   play_open: ", play_open, ", play_close: ", play_close)
	#print("   in_top: ", in_top, ", in_bottom: ", in_bottom)
	pass


func _ready():
	print(anim)
	print(root)
	print(player)
	print_states("ready")
	
func _process(delta):
	if play_open == true && Input.is_action_pressed("ui_accept"):
		play_open = false
		play_close = true
		print_states("process")
		if anim.is_playing():
			curr_frame = anim.get_frame()
		else: 
			curr_frame = 0
		anim.play("SlideOpen")
		anim.set_frame(curr_frame)
		playing_forward = true


func _on_animated_slide_door_frame_changed():
	curr_frame = anim.get_frame()

	if curr_frame % 2 == 0:
		if use_coll1: door_name = "1"
		else: door_name = "2"
		# Disable collision on previous frame
		curr_coll = get_node(str("CollDoor", door_name, "/Coll", prev_frame, "a"))
		curr_coll.set_deferred("disabled", true)
		curr_coll = get_node(str("CollDoor", door_name, "/Coll", prev_frame, "b"))
		curr_coll.set_deferred("disabled", true)
		
		# Enable collision on current frame
		curr_coll = get_node(str("CollDoor", door_name, "/Coll", curr_frame, "a"))
		curr_coll.set_deferred("disabled", false)
		curr_coll = get_node(str("CollDoor", door_name, "/Coll", curr_frame, "b"))
		curr_coll.set_deferred("disabled", false)
		
		prev_frame = curr_frame


func _on_PlayerDectectionLayering_body_entered(body):
	if body.name == "Player":
		player.z_index = anim.z_index + 1


func _on_PlayerDetectionLayering_body_exited(body):
	if body.name == "Player":
		player.z_index = initialPlayerZIndex


func _on_PlayerDetectionAnimation_body_entered(body):
	if body.name == "Player":
		if !play_close: play_open = true
		print_states("anim body entered")
	


func _on_PlayerDetectAnimCloseTop_body_entered(body):
	if body.name == "Player":
		in_top = true
		print_states("door top entered")
		
		if FIRST_CHECK == 0:
			# Disable collision on all CollDoor1 child nodes
			# Except for the closed door collision shapes
			for i in range(2,7,2):
				curr_coll = get_node(str("CollDoor1/Coll", i, "a"))
				curr_coll.set_deferred("disabled", true)
				curr_coll.disabled = true
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


func _on_PlayerDetectionAnimCloseTop_body_exited(body):
	if body.name == "Player":
		if play_close && !in_bottom:
			if anim.is_playing():
				curr_frame = anim.get_frame()
			else: 
				curr_frame = 7
			anim.play_backwards("SlideOpen")
			anim.set_frame(curr_frame)
			playing_forward = false
			use_coll1 = true
			play_close = false
		in_top = false
		print_states("door top exited")


func _on_PlayerDetectAnimCloseBottom_body_entered(body):
	if body.name == "Player":
		in_bottom = true
		print_states("door bottom entered")
		
		if FIRST_CHECK == 0:
			# Disable collision on all CollDoor1 child nodes
			for i in range(0,7,2):
				curr_coll = get_node(str("CollDoor1/Coll", i, "a"))
				curr_coll.set_deferred("disabled", true)
				curr_coll = get_node(str("CollDoor1/Coll", i, "b"))
				curr_coll.set_deferred("disabled", true)
			# Disable collision on all CollDoor2 child nodes
			# Except for the closed door collision shapes
			for i in range(2,7,2):
				curr_coll = get_node(str("CollDoor2/Coll", i, "a"))
				curr_coll.set_deferred("disabled", true)
				curr_coll = get_node(str("CollDoor2/Coll", i, "b"))
				curr_coll.set_deferred("disabled", true)
			
			use_coll1 = false
			FIRST_CHECK = 1


func _on_PlayerDetectAnimCloseBottom_body_exited(body):
	if body.name == "Player":
		if play_close && !in_top:
			if anim.is_playing():
				curr_frame = anim.get_frame()
			else: 
				curr_frame = 7
			anim.play_backwards("SlideOpen")
			anim.set_frame(curr_frame)
			playing_forward = false
			use_coll1 = false
			play_close = false
		in_bottom = false
		print_states("door bottom exited")

