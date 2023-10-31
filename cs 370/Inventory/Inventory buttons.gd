extends Node2D

@onready var inventory = get_node("/root/Inventory")

func _ready():
	print(inventory.get_player_position())


func _on_level_button_down():
	var path = inventory.get_current_level()
	get_tree().change_scene_to_file(path)

func _on_home_button_down():
	get_tree().change_scene_to_file("res://first_game.tscn")
