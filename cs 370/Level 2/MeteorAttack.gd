extends State

@export var meteorNode: PackedScene
@onready var timer = $MeteroShoot


func transition():
		pass
		
func enter():
	super.enter()
	timer.start()

func  exist():
	super.exit()
	timer.stop()


func _on_metero_shoot_timeout():
		shoot()
	


func shoot():
	var meteor = meteorNode.instantiate()
	
	meteor.position = global_position
	meteor.direction = (player.global_position - global_position).normalized()
	
	get_tree().current_scene.call_deferred("add_child",meteor)
	
	
	
	# figure out the logic later 