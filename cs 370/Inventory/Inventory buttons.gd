extends Node2D

@onready var inventory = get_node("/root/Inventory")

func _on_close_button_down():
	var previous_scene_path = inventory.get_prev_page()
	get_tree().change_scene_to_file(previous_scene_path)
