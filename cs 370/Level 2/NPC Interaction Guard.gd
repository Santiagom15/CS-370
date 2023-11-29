extends Node2D

# Track the current state of the guard:
#	0 for initial state in which guard can be interacted with
#	1 for when player is/can interact with guard to ask it to move and be prompted to retrieve coffee from locked boss battle room
#	2 for when player gives guard coffee and the guard moves
#	3 for guard is moved out of the way of the door and can no longer be interacted with
var curr_state = 0

# When player is in range of the guard for interaction
var play_interaction = false
# Boolean flag for playing current animation over again
var play_start = true

# Get nodes for Speech, including speech bubble and text nodes
@onready var speech = get_node("Speech")
@onready var speechBubble = speech.get_node("Speech bubble")
@onready var speechText = speech.get_node("Speech text")

# Get nodes for the frog/guard node, including animation player and collision shape
@onready var frogAnim = get_node("Frog")
@onready var frogCol = frogAnim.get_node("Collision body").get_child(0)

# Integer tracking which speech interaction has already played
var text_progress = 0

func _ready():
	speechBubble.hide()
	speechText.hide()
	speechBubble.z_index = 2
	speechText.z_index = 2
	
	frogAnim.play("Sleep")
	frogAnim.set_frame(0)


func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		print("- presssed: ", Input.is_action_pressed("ui_accept"))
	if Input.is_action_just_released("ui_accept"):
		print("- released: ", Input.is_action_just_released("ui_accept"))
	
	if play_interaction && Input.is_action_pressed("ui_accept"):
		play_interaction = false
		
		if curr_state == 0:
			if play_start:
				frogAnim.play("Idle")
				frogAnim.set_frame(0)
				play_start = false
			
			if text_progress == 0:
				text_progress = 1
				speechText.clear()
				speechText.append_text("[center]Oh, you want me to move? Hmm you'll need to do something for me in exchange...")
				speechBubble.show()
				speechText.show()
				
			elif text_progress == 1:
				text_progress = 0
				speechText.clear()
				speechText.append_text("[center]I left my coffee in the room across from the security room. Get if for me, and I'll move.")
				speechBubble.show()
				speechText.show()
	
	if !play_interaction && Input.is_action_just_released("ui_accept"):
		play_interaction = true


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		play_interaction = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		play_interaction = false
		
		speechBubble.hide()
		speechText.hide()
		frogAnim.play("Sleep")
		frogAnim.set_frame(0)
		
		play_start = true
		text_progress = 0
