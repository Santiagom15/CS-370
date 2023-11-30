extends Area2D
class_name spawnAttack
@onready var animated = $AnimatedSprite2D
var speed = 100
var direction:Vector2
var SelfCurrentPosition:Vector2
var SelfPlayerPosition:Vector2

func _ready():
	animated.play("groundAttack")

#always moving to the right bc of this 
func _physics_process(delta):
	position+= speed*delta*direction

func spawnAttack(PlayerPosition,CurrentPosition):
	SelfPlayerPosition = PlayerPosition
	SelfCurrentPosition = CurrentPosition
	direction = (SelfPlayerPosition - SelfCurrentPosition).normalized()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
