
extends Node2D

#set direction and speed of scalpel
var direction = Vector2.DOWN
var speed = 300

@onready var explodeTimer := $explodeTimer
@onready var global_hit = get_node("/root/Global")


#change position of scalpel based on direction and speed
func _physics_process(delta):
	position += direction * speed * delta

#when player enters collision area of scalpel (scalpel hits player)
func _on_hit_box_body_entered(body):
	if body.name == "player":
		global_hit.hits = global_hit.hits + 1	#increment hits
		$Sprite2D.play("explode")	
		speed = 0
		if(explodeTimer.is_stopped()):
			explodeTimer.start()
	if body.name == "Lane collision2":
		queue_free()


#after scalpel finishes exploding, remove it from scene
func _on_explode_timer_timeout():
	queue_free()
