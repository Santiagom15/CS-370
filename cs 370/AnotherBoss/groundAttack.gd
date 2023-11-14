extends State


@export var groundAttack: PackedScene
@onready var timer = $groundTimer
# Called when the node enters the scene tree for the first time.
func transition():
	if !ray_cast.is_colliding():
		get_parent().change_state('Idle')
		
func enter():
	super.enter()
	timer.start()

func  exist():
	super.exit()
	timer.stop()


func _on_ground_timer_timeout():
	spawn()
	
func spawn():
	var attack = groundAttack.instantiate()
	
	attack.position =player.position
	attack.direction = (player.global_position - global_position).normalized()
	
	get_tree().current_scene.call_deferred("add_child",attack)
