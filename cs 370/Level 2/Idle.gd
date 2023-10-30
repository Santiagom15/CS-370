extends State
class_name IdleState

func transition():
	if ray_cast.is_colliding():
		print("test")
		get_parent().change_state("Attack1")
