
extends Node2D

var direction = Vector2.DOWN
var speed = 300


@onready var timer := $Timer
@onready var global_hit = get_node("/root/Global")



func _physics_process(delta):
	position += direction * speed * delta

func _on_screen_exited():
	queue_free()


func _on_hit_box_body_entered(body):
	
	if body.name == "player":
		print("hit")
		global_hit.hits = global_hit.hits + 1
		queue_free()
			
		
	if body.name == "Lane collision2":
		print("hit edge")
		queue_free()

