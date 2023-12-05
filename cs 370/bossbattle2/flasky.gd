extends Node2D

#set direction and speed of flask attack
var direction = Vector2.DOWN
var speed = 250


@onready var explodeTimer := $explodeTimer	
@onready var global_var = get_node("/root/Global")


#set position of flask based on direction and speed
func _physics_process(delta):
	position += direction * speed * delta

#when flask hits player
func _on_hit_box_body_entered(body):
	if body.name == "player":
		global_var.hits2 = global_var.hits2 + 1		#increment hits
		$AnimatedSprite2D.play("spill")		#play spill animation
		$"hit box/spillCollision".visible = true	#make spill collision area visible so player loses health if it hits
		$"hit box/throwCollision".visible = false
		speed = 0
		if(explodeTimer.is_stopped()):
			explodeTimer.start()
		if(global_var.hits2 >= 6):		#if hits reaches 6, change scene to Lose Scene
			get_tree().change_scene_to_file("res://BossBattleLoseScene.tscn")
	
	if body.name == "Lane collision2":
		queue_free()


#when timer runs out, spill disappears
func _on_explode_timer_timeout():
	queue_free()

