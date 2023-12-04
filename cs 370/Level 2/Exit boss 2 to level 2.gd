extends Area2D

func _on_body_entered(body):
	if body.name == "player":
		get_tree().change_scene_to_file("res://Level 2/Floor 4.tscn")
