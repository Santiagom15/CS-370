extends State
class_name IdleForAnotherboss


func transition():# amethod from the parent class that we can use to transition to new states
	if ray_cast.is_colliding():
		get_parent().change_state("groundAttack")
#If statment .....
		


func animation():
	animator.play("Idle")# why can't it find this animation 
	
