extends Node2D

@onready var spikeTimer = $Timer	#timer for how long spikes last
@onready var global_var = get_node("/root/Global")

func _ready():
	pass # Replace with function body.


#restart timer when it runs out
func _process(delta):
	if(spikeTimer.is_stopped()):
		spikeTimer.start()

#when timer runs out, spikes disappear
func _on_timer_timeout():
	queue_free()

#when player exits area around spikes, set flag false
func _on_area_2d_body_exited(body):
	if body.name == "player":
		global_var.flag = false

#when player enters spikes, set flag true
func _on_area_2d_body_entered(body):
	if body.name == "player":
		if(global_var.flag == false):
			global_var.hits2 = global_var.hits2 + 1	
			$Hit.visible = true		#visible label indicating when player hits spike
			if(global_var.hits2 >= 6):		#when hits reaches 6, change scene
				get_tree().change_scene_to_file("res://BossBattleLoseScene.tscn")

		global_var.flag = true
