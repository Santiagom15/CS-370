extends Area2D


var speed = 100

func _physics_process(delta):
	position+= transform.x * speed*delta

