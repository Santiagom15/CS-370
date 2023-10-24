extends CharacterBody2D

# what you can do is  create global or non global variable that stays true as long as the farme you want is activated and false when it isn't
@export var speed = 300
@onready var _animated_sprite = $AnimatedSprite2D
@onready var heart = $Camera2D/press/Heart
@onready var timer =$Camera2D/Heart/Timer
@onready var press =$Camera2D/press
var heartbeat = 0.5
var heartFrame = 1.0
var space = false
var moving = false
var state:bool


func _ready():
	heart.play("heartBeat",heartbeat)

func getState():
	var isFrame=heart.get_frame()==1
	while isFrame:
		if isSpacePressed():
			return true
	return false
		
func isSpacePressed()->bool:
	var Space= Input.is_action_pressed("space")
	if Space :
		return true
	else:
		return false
	
		
func _on_heart_frame_changed():
		print(getState())
	#if getState() and isSpacePressed():
		#print("State: ",getState(), " Space: ",isSpacePressed())
	

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


