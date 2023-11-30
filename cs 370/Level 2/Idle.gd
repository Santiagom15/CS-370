extends SantisBossesState
class_name Idle

@onready var timer = $TestTimerFoMeteor # TODO going to learn how to restaurt everytime I finish the attacks// or connect to song an dchange base onf song 

func transition():# amethod from the parent class that we can use to transition to new states
	if ray_cast.is_colliding():
		get_parent().change_state("MeteorAttack")
#If statment .....
		


func animation():
	animator.play("idle")
	
