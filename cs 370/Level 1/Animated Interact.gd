extends CharacterBody2D

@onready var collDoor = $CollDoor
@onready var detectLeft = $PlayerDetectionFromLeft/CollisionShape2D
@onready var detectRight = $PlayerDetectionFromRight/CollisionShape2D
@onready var animRight = $AnimatedDoorRight
@onready var animLeft = $AnimatedDoorLeft
@onready var collTopLeft = $CollTopDoorLeft
@onready var collTopRight = $CollTopDoorRight

var play_open = false
var play_close = false
var left_open = false
var right_open = false

# Stack to record current position of player relative to door
# Value of 0 means player is to the left for the door, 1 means to the right
var stack_approach_side : Array = []
var len : int
var curr_side : int

func _ready():
	collTopLeft.set_deferred("disabled", true)
	collTopRight.set_deferred("disabled", true)
 

func _process(delta):
	len = stack_approach_side.size()
	if play_open == true && len == 2 && Input.is_action_pressed("ui_accept"):
		curr_side = stack_approach_side[len - 1]
		if curr_side == 0 && right_open == false:
			animRight.play("OpenRight")
			collDoor.set_deferred("disabled", true)  # Disable the CollisionShape2D
			collTopRight.set_deferred("disabled", false)
			play_open = false
			play_close = true
			left_open = true
		elif curr_side == 1 && left_open == false:
			animLeft.play("OpenLeft")
			collDoor.set_deferred("disabled", true)  # Disable the CollisionShape2D
			collTopLeft.set_deferred("disabled", false)
			play_open = false
			play_close = true
			right_open = true

func _on_PlayerDetectionFromLeft_body_entered(body):
	print("Entered from left")
	if body.name == "Player":  # Check if the colliding body is the player
		if !play_close:
			play_open = true
		if right_open:
			stack_approach_side.insert(0,0)
		else:
			stack_approach_side.append(0)
	var result = ""
	for element in stack_approach_side:
		result += str(element) + " "
	print("   stack elems:", result)
	print("   play_open: ", play_open, "   play_close: ", play_close)
	print("   right_open: ", right_open, "   left_open: ", left_open)


func _on_PlayerDetectionFromRight_body_entered(body):
	if body.name == "Player":  # Check if the colliding body is the player
		if !play_close:
			play_open = true
		if left_open:
			stack_approach_side.insert(0,1)
		else:
			stack_approach_side.append(1)
	var result = ""
	for element in stack_approach_side:
		result += str(element) + " "
	print("   stack elems:", result)
	print("   play_open: ", play_open, "   play_close: ", play_close)
	print("   right_open: ", right_open, "   left_open: ", left_open)


func _on_PlayerDetectionFromLeft_body_exited(body):
	if body.name == "Player":
		curr_side = stack_approach_side[stack_approach_side.size() - 1]
		if curr_side == 0:
			if play_close:
				collDoor.set_deferred("disabled", false)  # Disable the CollisionShape2D
				collTopRight.set_deferred("disabled", true)
				animRight.play("CloseRight")
				play_close = false
				left_open = false
			stack_approach_side.pop_back() 
		elif curr_side == 1:
			stack_approach_side.pop_front()
	var result = ""
	for element in stack_approach_side:
		result += str(element) + " "
	print("   stack elems:", result)
	print("   play_open: ", play_open, "   play_close: ", play_close)
	print("   right_open: ", right_open, "   left_open: ", left_open)


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
	var result = ""
	for element in stack_approach_side:
		result += str(element) + " "
	print("   stack elems:", result)
	print("   play_open: ", play_open, "   play_close: ", play_close)
	print("   right_open: ", right_open, "   left_open: ", left_open)
