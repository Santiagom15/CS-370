extends Node2D

var interaction_name = "Guard"

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
@onready var speechItem = speech.get_node("Item needed")

# Get nodes for the frog/guard node, including animation player and collision shape
@onready var frogAnim = get_node("Frog")
@onready var frogCol = frogAnim.get_node("Collision body").get_child(0)
@onready var frogItem = frogAnim.get_node("Item needed")
@onready var frogSparkle = frogAnim.get_node("Sparkle animation")

# Integer tracking which speech interaction has already played
var text_progress = 0

# Detection collision shape for detecting player
@onready var detect = get_node("PlayerDetection").get_child(0)

# Retrieve the game wide inventory, used to store data between scenes
@onready var inventory = get_node("/root/Inventory")

func _ready():
	if !inventory.has_interaction(interaction_name):
		inventory.update_interaction(interaction_name)
	
	speechBubble.hide() 
	speechText.hide()
	speechItem.play("Coffee")
	speechItem.hide()
	frogItem.hide()
	frogSparkle.hide()
	speechBubble.z_index = 2
	speechText.z_index = 2
	speechItem.z_index = 2
	
	frogAnim.play("Sleep")
	frogAnim.set_frame(0)
	
	if inventory.get_interaction_state(interaction_name) == 3:
		frogAnim.position = Vector2(3988, 1315)
		detect.set_deferred("disabled", true)
		
		frogItem.show()
		frogItem.play("Coffee")


func _process(delta):
	
	curr_state = inventory.get_interaction_state(interaction_name)
	
	if curr_state < 3 && play_interaction && Input.is_action_just_released("ui_accept"):
		
		if curr_state == 0 || curr_state == 1:
			if inventory.has_item("Coffee"):
				inventory.set_interaction(interaction_name, 2)
				curr_state = 2
			
			else:
				if play_start:
					frogAnim.play("Idle")
					frogAnim.set_frame(0)
					play_start = false
				
				if text_progress == 0:
					speechText.clear()
					speechText.append_text("[center]Oh, you want me to move? Hmm you'll need to do something for me in exchange...")
					speechBubble.show()
					speechText.show()
					speechItem.hide()
					
					text_progress = 1
					
				elif text_progress == 1:
					speechText.clear()
					speechText.append_text("[center]I left my coffee in the room across from the security room. Get it for me, and I'll move.")
					speechBubble.show()
					speechText.show()
					speechItem.show()
					
					if curr_state == 0:
						inventory.update_interaction(interaction_name)
					
					text_progress = 0
	
		if curr_state == 2:
			
			if text_progress == 0:
				frogAnim.play("Idle")
				frogAnim.set_frame(0)

				inventory.remove_item("Coffee")
				
				speechText.clear()
				speechText.append_text("[center] Yum.        -              Thanks for the coffee, good luck with your escape, human.")
				speechBubble.show()
				speechText.show()
				speechItem.show()
				
				text_progress = 1
			
			elif text_progress == 1:
				speechBubble.hide()
				speechText.hide()
				speechItem.hide()
				
				inventory.update_interaction(interaction_name)
				frogAnim.play("Hop")


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		play_interaction = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		play_interaction = false
		
		speechBubble.hide()
		speechText.hide()
		speechItem.hide()
		frogAnim.play("Sleep")
		frogAnim.set_frame(0)
		
		play_start = true
		text_progress = 0


func _on_frog_frame_changed():
	if frogAnim.get_animation() == "Hop":
		frogAnim.position = Vector2(frogAnim.position.x - 22, frogAnim.position.y - 30)


func _on_frog_animation_finished():
	if frogAnim.get_animation() == "Hop":
		frogAnim.play("Sleep")
		frogAnim.set_frame(0)
		frogItem.show()
		frogItem.play("Coffee")
		frogSparkle.show()
		frogSparkle.play("Idle")
		frogSparkle.set_frame(0)
		detect.set_deferred("disabled", true)


func _on_sparkle_animation_animation_finished():
	frogSparkle.hide()
