extends Node2D

var direction = Vector2.DOWN
var speed = 250


@onready var timer := $Timer
@onready var explodeTimer := $explodeTimer
@onready var global_var = get_node("/root/Global")



func _physics_process(delta):
	position += direction * speed * delta

func _on_screen_exited():
	queue_free()


func _on_hit_box_body_entered(body):
	if body.name == "player":
		global_var.hits2 = global_var.hits2 + 1
		$AnimatedSprite2D.play("spill")
		$"hit box/spillCollision".visible = true
		$"hit box/throwCollision".visible = false
		speed = 0
		if(explodeTimer.is_stopped()):
			explodeTimer.start()
		if(global_var.hits2 >= 6):
			get_tree().change_scene_to_file("res://BossBattleLoseScene.tscn")
			
					
		
	if body.name == "Lane collision2":
		queue_free()



func _on_explode_timer_timeout():
	queue_free()

