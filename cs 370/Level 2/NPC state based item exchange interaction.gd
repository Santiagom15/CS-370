extends Node2D

@onready var interaction_name = get_name()

# Track the state of the NPC interaction. Depending on the state, the player can interact with the NPC in different ways
#	0: Player cannot interaction with the NPCs
#	1: Player can interact. When player interacts (presses spacebar in range), dialogue will appear saying what the NPC has and what they'll give in exchange for it
#	2: Player can interact. Player gives up the item the NPC wants, and in exchange recieves the item the NPC has. What NPC has will dissapear from scene, but appear in player inventory, and what NPC recieves will appear in scene and out of player inventory.
#	3: Player cannot interact. 
var curr_state = 0

# When player is in range of the NPC for interaction
var play_interaction = false
# In diaolgue interaction, track which dialogue segement of the current state you're on
var text_progress = 0

# Retrieve the game wide inventory, used to store data between scenes
@onready var inventory = get_node("/root/Inventory")

# Get nodes for Speech, including speech bubble, text nodes, and animation nodes for items
@onready var speech = get_node("Speech")
@onready var speechBubble = speech.get_node("Speech bubble")
@onready var speechText = speech.get_node("Speech text")
@onready var speechItemWant = speech.get_child(2)
@onready var item_want = str(speechItemWant.get_name())
@onready var speechItemGive = speech.get_child(3)
@onready var item_give = str(speechItemGive.get_name())

# Item to display once collected and retrieved by the NPCs
@onready var itemRetrieved = get_node("Item collected")
@onready var itemSparkle = get_node("Sparkle animation")

# Detection collision shape for detecting player for interaction
@onready var detectInteraction = get_node("PlayerDetectionInteraction").get_child(0)
# Detection collision shape for detecting player for collecting the wanted item
@onready var node_item_give = "Collectible item " + item_give.to_lower() + " 0"
@onready var detectItem = get_parent().get_parent().get_node("Collectible items").get_node(node_item_give).get_child(0).get_node("PlayerDetectionItem").get_child(0)

# The dialogue options based on the specific NPC interaction
var descriptions: Dictionary = {}
var descriptionPositions: Dictionary = {}

func _ready():
	
	if !inventory.has_interaction(interaction_name):
		inventory.update_interaction(interaction_name)
	
	speechBubble.hide()
	speechText.hide()
	speechItemWant.hide()
	speechItemWant.play("Idle")
	speechItemGive.hide()
	speechItemGive.play("Idle")
	itemRetrieved.hide()
	itemSparkle.hide()
	
	speechBubble.z_index = 2
	speechText.z_index = 2
	speechItemWant.z_index = 2
	speechItemGive.z_index = 2
	
	curr_state = inventory.get_interaction_state(interaction_name)
	if curr_state == 0:
		detectItem.set_deferred("disabled", true)
	elif curr_state == 3:
		detectInteraction.set_deferred("disbaled", true)
		itemRetrieved.show()
		itemRetrieved.play("Idle")
	
	
	descriptions["Thanks"] = """Thank you
for the

Here is your"""
	descriptions["Office 20"] = "Hello human, would you like this lovely ▶"
	descriptions["Office 21"] = """In exchange... 
Fetch us a human.  	------ Yours seems -------  nice, but any -----     will do""" 
	descriptions["Office 10"] = """Oh, you want
 this strange
 green plant
 do you?
 Perhaps... ▶"""
	descriptions["Office 11"] = """In exchange, fetch us a blue flower. We 
			 need one more
			 to have one 
			 for each of us."""
	descriptions["Room 30"] = """Nice hat
 hmmm?
 I think you 
could like it, let's make a deal? ▶"""
	descriptions["Room 31"] = """          I'm trying to use
		  the vending 
		  machine, 
		  got any cash?"""
	descriptions["Room 10"] = """Trying to break into a room huh? This could be helpful... ▶"""
	descriptions["Room 11"] = """That green
 frog stole
 my hat, get it back human, and I'll give you what you want."""
			
	descriptionPositions = {
		"Room 10": Vector2(3914, 1580),
		"Room 11": Vector2(3978, 1447),
		"Room 12": Vector2(3943, 1600),
		"Room 13": Vector2(3961, 1451),
		"Room 30": Vector2(3994, 1465),
		"Room 31": Vector2(3797, 1517),
		"Room 32": Vector2(3981, 1536),
		"Room 33": Vector2(3954, 1458),
		"Office 10": Vector2(3986, 1536),
		"Office 11": Vector2(3809, 1561),
		"Office 12": Vector2(3972, 1598),
		"Office 13": Vector2(3934, 1438),
		"Office 20": Vector2(3949, 1568.88),
		"Office 21": Vector2(3795, 1536),
		"Office 22": Vector2(4008, 1576),
		"Office 23": Vector2(3960, 1445),
	}



func _process(delta):
	if inventory.get_interaction_state(interaction_name) == 3: return
	
	if inventory.has_item(item_want) && inventory.get_interaction_state("Guard") > 0:
		detectItem.set_deferred("disabled", false)
		inventory.set_interaction(interaction_name, 2)
	elif inventory.get_interaction_state("Guard") > 0:
		inventory.set_interaction(interaction_name, 1)
		
	curr_state = inventory.get_interaction_state(interaction_name)
	
	if play_interaction && Input.is_action_just_released("ui_accept"):
		if curr_state == 0:
			speechText.clear()
			speechText.append_text("Go talk to the frog by the stairs, human, then come back...")
			speechBubble.show()
			speechText.show()
			speechItemWant.hide()
			speechItemGive.hide()
		
		if curr_state == 1:
			if text_progress == 0:
				speechText.clear()
				speechText.append_text(descriptions[str(interaction_name + "0")])
				speechBubble.show()
				speechText.show()
				speechItemWant.hide()
				speechItemGive.position = descriptionPositions[str(interaction_name + "0")]
				speechItemGive.show()
					
				text_progress = 1
					
			elif text_progress == 1:
				speechText.clear()
				speechText.append_text(descriptions[str(interaction_name + "1")])
				speechBubble.show()
				speechText.show()
				speechItemWant.position = descriptionPositions[str(interaction_name + "1")]
				speechItemWant.show()
				speechItemGive.hide()
				
				text_progress = 0
		
		elif curr_state == 2:
			speechText.clear()
			speechText.append_text(descriptions["Thanks"])
			speechBubble.show()
			speechText.show()
			speechItemGive.position = descriptionPositions[str(interaction_name + "2")]
			speechItemWant.position = descriptionPositions[str(interaction_name + "3")]
			speechItemWant.show()
			speechItemGive.show()
			
			inventory.update_interaction(interaction_name)
			inventory.remove_item(item_want)
			
			detectInteraction.set_deferred("disbaled", true)
			itemRetrieved.show()
			itemRetrieved.play("Idle")
			itemSparkle.show()
			itemSparkle.play("Idle")
			itemSparkle.set_frame(0)



func _on_player_detection_interaction_body_entered(body):
	if body.name == "Player":
		play_interaction = true


func _on_player_detection_interaction_body_exited(body):
	if body.name == "Player":
		play_interaction = false
		
		speechBubble.hide()
		speechText.hide()
		speechItemWant.hide()
		speechItemGive.hide()
		
		text_progress = 0


func _on_sparkle_animation_animation_finished():
	itemSparkle.hide()
