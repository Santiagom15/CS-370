extends CharacterBody2D

# what you can do is  create global or non global variable that stays true as long as the farme you want is activated and false when it isn't
@export var speed = 300
@onready var _animated_sprite = $AnimatedSprite2D
@onready var heart = $Camera2D/press/Heart
@onready var timer =$Camera2D/press/Timer
@onready var press =$Camera2D/press
@onready var background = $CanvasLayer/ColorRect
var heartbeat = 0.5
var heartFrame = 1.0
var space = false
var moving = false
var state:bool
var accuracy = 1.0


func _ready():
	heart.play("heartBeat",0)
	heart.set_frame(0)

		
func isSpacePressed()->bool:
	var Space= Input.is_action_pressed("space")
	if Space :
		return true
	else:
		return false
	
		
func _on_heart_frame_changed():
	print("Moving: ",moving," space: ",isSpacePressed()," stat: ",state)
	#if getState() and isSpacePressed():
		#print("State: ",getState(), " Space: ",isSpacePressed())
	
func test():
	print("Moving: ",moving," space: ",isSpacePressed()," stat: ",state)
	
	
func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")	
	if input_direction:
		moving = true
	else: 
		moving = false
	velocity = input_direction * speed
	
  
func _physics_process(_delta):
	get_input()     
	move_and_slide()
	checkingConditions()

func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.play("walkright_aisha")
	elif Input.is_action_pressed("ui_left"):
		_animated_sprite.play("walkleft_aisha")
	elif Input.is_action_pressed("ui_up"):
		_animated_sprite.play("walk_backAisha")
	elif Input.is_action_pressed("ui_down"):  
		_animated_sprite.play("walk_fowardAisha")
	else:
		_animated_sprite.pause()
		
func checkingConditions():
	if moving:
		if space:
			accuracy = 2.0
		else:
			accuracy -= 0.05
	else:
		if state == false and space == false:
			accuracy += 0.15
		else:
			if accuracy < 0.5:
				accuracy += 0.1
	
	calcAccuracy(accuracy)


func _on_timer_timeout():
	if heart.get_frame() == 0:
		heart.set_frame(1)# 1 is the light 
		state = false
	elif heart.get_frame() == 1:
		heart.set_frame(0)# is dark 
		state = true

func calcAccuracy(accuracy:float):
	var minAccToDarken = 0.0
	#should change from self.molduate to the scene but idk
	if accuracy < minAccToDarken:
		var darkenColor = Color(0,0,0,1 - accuracy)
		background.modulate = darkenColor
	else:
		background.modulate = Color(1,1,1,1)
