extends State
class_name Idle


func transition():
	if ray_cast.is_colliding():
		print("test")
		get_parent().change_state("Attack1")


func animation():
	animator.play("idle")
	
