extends Button

func _on_button_down():
	get_tree().change_scene_to_file("res://my_world.tscn")

func _on_test_no_bg_button_down():
	get_tree().change_scene_to_file("res://demo/demos_no_background.tscn")

func _on_level_1_button_down():
	get_tree().change_scene_to_file("res://Level 1/floor5.tscn")

func _on_level_2_button_down():
	get_tree().change_scene_to_file("res://Level 2/Floor 4.tscn")

func _on_level_3_button_down():
	get_tree().change_scene_to_file("res://Level 3/Floor 2.tscn")

func _on_level_5_button_down():
	get_tree().change_scene_to_file("res://Level 5/Floor 1.tscn")

func _on_inventory_button_down():
	get_tree().change_scene_to_file("res://Inventory/Inventory.tscn")

func _on_level_menu_button_down():
	get_tree().change_scene_to_file("res://Level Navigation/level_select.tscn")

func _on_play_button_down():
	get_tree().change_scene_to_file("res://Level 1/floor5.tscn")
