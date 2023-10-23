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
	_onTime()
	
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
	_onTime()
	get_input()
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




func _onTime():
	#print(heart.get_frame()==heartFrame)
	print(heart.get_playing_speed())
	if heart.get_playing_speed() > 3: # moves to previous save in the future 
		heartbeat==0.5
		heart.play("heartBeat",heartbeat)
		
	if moving and heartFrame==heart.get_frame() and space:  
		heart.play("heartBeat",heartbeat)
		
	elif moving and heartFrame!=heart.get_frame():
		heartbeat = heartbeat + 0.1                    
		heart.play("heartBeat",heartbeat)
		
	else:
		if heartbeat >0.5:
			heartbeat = heartbeat - 0.1
		heart.play("heartBeat",heartbeat)
		
	
		

func _on_heart_animation_looped():
	pass # Replace with function body.
