extends Node2D

func _on_home_page_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://first_game.tscn")


func _on_inventory_page_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Inventory/Inventory.tscn")


func _on_level_1_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Level 1/floor5.tscn")


func _on_level_2_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Level 2/floor4.tscn")


func _on_level_5_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Level 5/Floor 1.tscn")
