extends Node2D

@onready var animated = $AnimatedSprite2D
var direction = Vector2.ONE
var speed = 100

func _physics_process(delta):
	position+= direction * speed*delta
	animated.play("groundAttack")


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
