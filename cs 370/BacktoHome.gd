extends Button





func _on_button_down():
	get_tree().change_scene_to_file("res://my_world.tscn")


func _on_test_button_down():
	get_tree().change_scene_to_file("res://demo/demos.tscn")
