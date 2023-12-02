extends Node2D

@onready var inventory = get_node("/root/Inventory")

func clear_data_transition(transition_level):
	if inventory.get_current_level() != transition_level:
		inventory.clear_level_data()

func _on_home_page_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://first_game.tscn")


func _on_inventory_page_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Inventory/Inventory.tscn")


func _on_level_1_body_entered(body):
	if body.name == "Player":
		clear_data_transition("res://Level 1/floor5.tscn")
		get_tree().change_scene_to_file("res://Level 1/floor5.tscn")


func _on_level_2_body_entered(body):
	if body.name == "Player":
		clear_data_transition("res://Level 2/Floor 4.tscn")
		get_tree().change_scene_to_file("res://Level 2/Floor 4.tscn")


func _on_level_5_body_entered(body):
	if body.name == "Player":
		clear_data_transition("res://Level 5/Floor 1.tscn")
		get_tree().change_scene_to_file("res://Level 5/Floor 1.tscn")
