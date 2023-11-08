extends State
class_name ShootState

@export var scalpely_node : PackedScene
@onready var timer = $Timer

#func transition():
	#get_parent().change_state("Idle")
	
func enter():
	super.enter()
	timer.start()

func exit():
	super.exit()
	timer.stop()


func _on_timer_timeout():
	shoot()
	
func shoot():
	var scalpely = scalpely_node.instantiate()
	
	scalpely.position = global_position + Vector2(30,35)
	scalpely.direction = Vector2.DOWN
	
	get_tree().current_scene.call_deferred("add_child", scalpely)
	
