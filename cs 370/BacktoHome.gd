extends Button





func _on_button_down():
	get_tree().change_scene_to_file("res://my_world.tscn")


func _on_test_button_down():
	get_tree().change_scene_to_file("res://demo/demos.tscn")


func _on_test_no_bg_button_down():
	get_tree().change_scene_to_file("res://demo/demos_no_background.tscn")
<<<<<<< HEAD


func _on_level_1_button_down():
	get_tree().change_scene_to_file("res://Level 1/floor5.tscn")
=======
>>>>>>> e84b4c03314b9fb0716ab11130121d1f943c9d5b
