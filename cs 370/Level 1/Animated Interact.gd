extends CharacterBody2D

@onready var collDoor = $CollDoor
@onready var animRight = $AnimatedDoorRight
@onready var animLeft = $AnimatedDoorLeft

var in_coll = false
var coll_from_left = true  # true when door approached on the left, false when approached from the right


func _process(delta):
	if in_coll == true && Input.is_action_pressed("ui_accept"):
		if coll_from_left == true:
			animRight.play("OpenRight")
			collDoor.set_deferred("disabled", true)  # Disable the CollisionShape2D
			in_coll = false
		else:
			animLeft.play("OpenLeft")
			collDoor.set_deferred("disabled", true)  # Disable the CollisionShape2D
			in_coll = false
		#collDetect.set_deferred("disabled", true)
#	elif in_coll == false:
#		collDoor.set_deferred("disabled", false)  # Disable the CollisionShape2D
#		collDetect.set_deferred("disabled", false)
		
#	if $CollDoor.disabled == false:
#		print("entered collDoor is enabled")
#	else:
#		print("entered collDoor is disabled")
#	if $PlayerDetection/CollisionShape2D.disabled == false:
#		print("entered collDetect is enabled")
#	else:
#		print("entered collDetect is disabled")
	

func _on_PlayerDetectionFromLeft_body_entered(body):
	print("Entered")
	if body.name == "Player":  # Check if the colliding body is the player
		in_coll = true
		
func _on_PlayerDetectionFromRight_body_entered(body):
	pass # Replace with function body.

func _on_PlayerDetectionFromLeft_body_exited(body):
	print("Exited")
	if body.name == "Player" && in_coll == false:
		if coll_from_left == true:
			animRight.play("CloseRight")
			collDoor.set_deferred("disabled", false)  # Disable the CollisionShape2D
			in_coll = false
			coll_from_left = false
		else:
			animLeft.play("CloseLeft")
			collDoor.set_deferred("disabled", false)  # Disable the CollisionShape2D
			in_coll = false
			coll_from_left = true


func _on_PlayerDetectionFromRight_body_exited(body):
	pass # Replace with function body.
