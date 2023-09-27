extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var _animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")#Check how this works becasue our physics might be different 


func _physics_process(_delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta

	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept"): #and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up","ui_down")
	if directionX and !directionY:
		velocity.x = directionX * SPEED
	elif directionY and !directionX:
		velocity.y=directionY * SPEED
	elif directionY and directionX:
		velocity.y=directionY * SPEED * (1.0 / sqrt(2.0))
	else:
		#understand these fucntions
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y=  move_toward(velocity.y,0,SPEED)

	move_and_slide()

func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.play("walk_right")
	elif Input.is_action_pressed("ui_left"):
		_animated_sprite.play("walk_left")
	elif Input.is_action_pressed("ui_up"):
		_animated_sprite.play("walk_backward")
	elif Input.is_action_pressed("ui_down"):
		_animated_sprite.play("walk_forward")
	else:
		_animated_sprite.stop()
	
	


func _on_button_button_down():
	get_tree().change_scene_to_file("res://first_game.tscn")


func _on_return_home_button_down():
	get_tree().change_scene_to_file("res://first_game.tscn")
