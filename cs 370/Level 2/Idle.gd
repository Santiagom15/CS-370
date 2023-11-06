extends State
class_name Idle

@onready var timer = $TestTimerFoMeteor# going to learn how to restaurt everytime I finish th attacks
func transition():
	if ray_cast.is_colliding():
		print("test")
		get_parent().change_state("Attack1")
		
	if timer.timeout():
		get_parent().change_state("MeteorAttack")
		


func animation():
	animator.play("idle")
	
