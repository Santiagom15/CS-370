extends Area2D


var speed = 100

func _physics_process(delta):
	position+= transform.x * speed*delta


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
