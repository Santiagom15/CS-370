extends State


# Called when the node enters the scene tree for the first time.
func transition():
	if !ray_cast.is_colliding():
		get_parent().change_state('Idle')
