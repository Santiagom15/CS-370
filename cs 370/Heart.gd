extends CharacterBody2D


@onready var _animated_sprite = $AnimatedSprite2D

@onready var timmy = $AudioStreamPlayer2D


# Get the gravity from the project settings to be synced with RigidBody nodes.

	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta

	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept"): #and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
func _process(_delta):
	$AudioStreamPlayer2D.get_time()
	var t = int(timmy.time)
	print("Time is: ", t)
	if(t < 15):
		if(t % 4 == 0):
			_animated_sprite.play("beat")
	elif(t < 20):
		_animated_sprite.play("beat")
	else:
		if(t % 2 == 0):
			_animated_sprite.play("beat")
		
	
