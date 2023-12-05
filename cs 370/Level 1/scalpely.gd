
extends Node2D

var direction = Vector2.DOWN
var speed = 300


@onready var timer := $Timer
@onready var explodeTimer := $explodeTimer
@onready var global_hit = get_node("/root/Global")



func _physics_process(delta):
	position += direction * speed * delta

func _on_screen_exited():
	queue_free()


func _on_hit_box_body_entered(body):
	if body.name == "player":
		global_hit.hits = global_hit.hits + 1
		$Sprite2D.play("explode")
		speed = 0
		if(explodeTimer.is_stopped()):
			explodeTimer.start()
			
		
	if body.name == "Lane collision2":
		queue_free()



func _on_explode_timer_timeout():
	queue_free()
