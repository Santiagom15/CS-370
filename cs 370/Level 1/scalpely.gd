
extends Node2D

var direction = Vector2.DOWN
var speed = 400


@onready var timer := $Timer



func _physics_process(delta):
	position += direction * speed * delta

func _on_screen_exited():
	queue_free()


func _on_hit_box_body_entered(body):
	
	if body.name == "player":
		print("hit")
		
		get_tree().change_scene_to_file("res://first_game.tscn")
		
	if body.name == "Lane collision2":
		print("hit edge")
		queue_free()

