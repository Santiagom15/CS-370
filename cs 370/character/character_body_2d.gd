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
	if directionX:
		velocity.x = directionX * SPEED
	elif directionY:
		velocity.y=directionY * SPEED
	else:
		#understand these fucntions
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y=  move_toward(velocity.y,0,SPEED)

	move_and_slide()

func _process(_delta):
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up"):
		_animated_sprite.play("run")
	else:
		_animated_sprite.stop()
	
	
