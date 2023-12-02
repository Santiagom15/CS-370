extends SantisBossesState

@export var meteorNode: PackedScene
@onready var timer = $MeteroShoot



		
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
	
	meteor.position = global_position + Vector2(150,0)
	meteor.direction = (player.position - meteor.position).normalized()
	
	get_tree().current_scene.call_deferred("add_child",meteor)
	
	
	
	# figure out the logic later 
