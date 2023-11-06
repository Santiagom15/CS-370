extends State
class_name Idle

@onready var timer = $Idle_timer
func transition():
	if ray_cast.is_colliding():
		print("test")
		get_parent().change_state("Attack1")
		
	if timer.timeout():
		pass
		


func animation():
	animator.play("idle")
	
