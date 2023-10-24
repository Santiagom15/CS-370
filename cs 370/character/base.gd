extends CharacterBody2D

# what you can do is  create global or non global variable that stays true as long as the farme you want is activated and false when it isn't
@export var speed = 300
@onready var _animated_sprite = $AnimatedSprite2D
@onready var heart = $Camera2D/Heart
@onready var timer =$Camera2D/Heart/Timer
var heartbeat = 0.5
var heartFrame = 1.0
var space = false
var moving = false
var isFrame: bool



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
	print(heart.get_playing_speed())
	#print(heart.get_playing_speed())
	if heart.get_playing_speed() > 3: # moves to previous save in the future 
		heartbeat==0.5
		heart.play("heartBeat",heartbeat)
		
	if moving and isFrame and space:  #in this case you are doing everything right
		heart.play("heartBeat",heartbeat)
	elif !moving:
		if heartbeat >0.5:
			heartbeat = heartbeat - 0.1
		heart.play("heartBeat",heartbeat)
		
	elif moving and !isFrame and space:# your moving and presing space on the wrong time
		heartbeat = heartbeat + 0.1                    
		heart.play("heartBeat",heartbeat)	
	else:
		pass
		
		
	
		

	
