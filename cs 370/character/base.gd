extends CharacterBody2D

# what you can do is  create global or non global variable that stays true as long as the farme you want is activated and false when it isn't
@export var speed = 300
@onready var _animated_sprite = $AnimatedSprite2D
@onready var heart = $Camera2D/Heart
@onready var timer =$Camera2D/Heart/Timer
@onready var background = $CanvasLayer/ColorRect
var heartbeat = 0.1
var heartFrame = 1.0
var space = false
var moving = false
var isFrame: bool
var accuracy = 1.0

func _ready():
	heart.play("heartBeat")
	
func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")	
	if input_direction:
		moving = true
	else: 
		moving = false
		
	var Space= Input.is_action_pressed("space")
	if Space :
		space = true 
	else:
		space = false
	velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	_onTime()
	move_and_slide()

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

func _onTime():# check different scnarios 
	
	isFrame = heartFrame==heart.get_frame()
	heart.play("heartBeat",heartbeat)
	#print(heart.get_playing_speed())
	print(accuracy)
	#need to figureout how to make the heartbeat seperate and constant 
	#updating accuracy based on player input
	if moving and isFrame and space:
		heart.play("heartBeat",heartbeat)
		accuracy = 1.0
	elif moving and not isFrame and space:
		heart.play("heartBeat",heartbeat)
		accuracy -= 0.1
	elif moving and isFrame and not space:
		heart.play("heartBeat",heartbeat)
		accuracy -= 0.1
	else:
		heart.play("heartBeat",heartbeat)
		if accuracy < 0.5:
			accuracy += 0.1
	calcAccuracy(accuracy)
		
func calcAccuracy (accuracy: float):
	var minAccToDarken = 0.5
	#should change from self.molduate to the scene but idk
	if accuracy < minAccToDarken:
		var darkenColor = Color(0,0,0,1 - accuracy)
		background.modulate = darkenColor
	else:
		background.modulate = Color(1,1,1,1)
