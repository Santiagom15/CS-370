extends Area2D

@onready var animated = $AnimatedSprite2D
var direction = Vector2.RIGHT #right
var speed = 100

func _ready():
	animated.play("groundAttack")

#always moving to the right bc of this 
func _physics_process(delta):
	position+= direction * speed * delta
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
