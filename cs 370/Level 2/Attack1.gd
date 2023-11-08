extends State
class_name Attack1


func transition():
	if !ray_cast.is_colliding():
		get_parent().change_state("Idle")
		

func animation():
	animator.play("attack")
