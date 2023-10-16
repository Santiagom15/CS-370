extends CharacterBody2D

@onready var anim = get_node("AnimatedSlideDoor")
@onready var root = get_parent()
@onready var player = root.get_node("Player")
@onready var initialPlayerZIndex = player.z_index
@onready var collDoor1 = $CollDoor1
@onready var collDoor2 = $CollDoor2

# Value of 0 mean no collision boxes for this door have been entered
# Value of 1 means either PlayerDetectionAnimCloseTop or PlayerDetectionAnimCloseBottom has been entered
var FIRST_CHECK = 0

var play_open = false
var play_close = false

var in_top = false
var in_bottom = false

var curr_frame = 0


func print_states(input_string: String):
	print(input_string)
	print("   play_open: ", play_open, ", play_close: ", play_close)
	print("   in_top: ", in_top, ", in_bottom: ", in_bottom)
	print("   CollDoor1 enabled: ", !(collDoor1.disabled), ", CollDoor2 enabled: ", !(collDoor2.disabled))


func _ready():
	print(anim)
	print(root)
	print(player)
	print_states("ready")
	
func _process(delta):
	if play_open == true && Input.is_action_pressed("ui_accept"):
		#curr_frame = anim.get_frame()
		#print(curr_frame)
		anim.play("SlideOpen")
		#curr_frame = anim.get_frame()
		#print(curr_frame)
		collDoor1.set_deferred("disabled", true)  # Disable the CollisionShape2D
		collDoor2.set_deferred("disabled", true)
		play_open = false
		play_close = true
		print_states("process")


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
		if FIRST_CHECK == 0:
			collDoor2.set_deferred("disabled", true)
			FIRST_CHECK = 1
		in_top = true
		print_states("door top entered")


func _on_PlayerDetectionAnimCloseTop_body_exited(body):
	if body.name == "Player":
		if play_close && !in_bottom:
			anim.play("SlideClosed")
			collDoor1.set_deferred("disabled", false)
			play_close = false
		in_top = false
		print_states("door top exited")


func _on_PlayerDetectAnimCloseBottom_body_entered(body):
	if body.name == "Player":
		if FIRST_CHECK == 0:
			collDoor1.set_Defered("disbaled", true)
			FIRST_CHECK = 1
		in_bottom = true
		print_states("door bottom entered")



func _on_PlayerDetectAnimCloseBottom_body_exited(body):
	if body.name == "Player":
		if play_close && !in_top:
			anim.play("SlideClosed")
			collDoor2.set_deferred("disabled", false)
			play_close = false
		in_bottom = false
		print_states("door bottom exited")

