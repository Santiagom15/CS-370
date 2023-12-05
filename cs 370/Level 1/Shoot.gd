extends State
class_name ShootState

@export var scalpely_node : PackedScene
@onready var timer = $Timer

#method to transition to Idle state
func transition():
	get_parent().change_state("Idle")

#method to enter Shoot state
func enter():
	super.enter()
	timer.start()

#method to exit Shoot state
func exit():
	super.exit()
	timer.stop()

#time between attacks
func _on_timer_timeout():
	shoot()
	
#method to shoot scalpels from boss
func shoot():
	var scalpely = scalpely_node.instantiate()
	get_parent().get_parent().get_node("AnimatedSprite2D").play("Shoot")	#play shoot animation

	scalpely.position = global_position + Vector2(30,35)	#make scalpel come from boss hand
	scalpely.direction = Vector2.DOWN
	
	get_tree().current_scene.call_deferred("add_child", scalpely)
	
