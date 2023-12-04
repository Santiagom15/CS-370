extends Node2D

@onready var spikeTimer = $Timer
@onready var global_var = get_node("/root/Global")


#@onready var battle2 = preload("res://bossbattle2/bossbattle2.tscn")
#@onready var health = battle2.get_node("HealthBar")
#@onready var curr_health = 6
#var healtharr = [0, 0.5, 1, 1.5, 2, 2.5, 3]# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(spikeTimer.is_stopped()):
		spikeTimer.start()
	#if(spikeTimer.is_stopped()):
	#	spikeTimer.start()


func _on_timer_timeout():
	queue_free()
	


#func _on_area_2d_body_entered(body): 
		#if body.name == "player":
		#	print("hit")
		#	global_hit.hits2 = global_hit.hits2 + 1
		#	print(global_hit.hits2)




func _on_area_2d_body_exited(body):
	if body.name == "player":
		global_var.flag = false


func _on_area_2d_body_entered(body):
	if body.name == "player":
		if(global_var.flag == false):
			global_var.hits2 = global_var.hits2 + 1
			$Hit.visible = true
			if(global_var.hits2 >= 6):
				get_tree().change_scene_to_file("res://BossBattleLoseScene.tscn")
			#curr_health = curr_health - 1
			print(global_var.hits2)
		global_var.flag = true
