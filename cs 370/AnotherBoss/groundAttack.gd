extends State

var switchState = false
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
	
func _on_delay_timeout():
	switchState = true
	
func spawn():
	var attack = groundAttack.instantiate()
	attack._ready()
	attack.position =player.position	
	while attack.get_StateInString()=='warning':
		if attack.get_StateInString()=='damage':#this is not being called
			
			attack.direction = (player.global_position - attack.position).normalized()
			
		break
		
	
	get_tree().current_scene.call_deferred("add_child",attack)

