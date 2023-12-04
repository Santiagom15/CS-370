# Script for the menu page
# Including scripting for buttons to access different pages in the game plus the debugging buttons to access all levels
extends Node2D

# Parent node for all of the level buttons to directly access any level without needing to unlock them through previous level completion
@onready var debugButtons = get_node("Debugging level buttons")

# Parent node to all of the idle animations in the scene
@onready var idleAnims = get_node("Idle animation nodes")

# Instance of the instructions page scene. Toggle visibility when user presses the "Instructions" button
@onready var instructionsPage = get_node("Instructions page")

# Retrieve the game wide inventory, used to store data between scenes
@onready var inventory = get_node("/root/Inventory")

func _ready():
	# Turn off the visibility on the debug level buttons so they cannot be easily accessed
	debugButtons.visible = false
	for child_idx in range(get_child_count()):
		var anim = idleAnims.get_child(child_idx)
		anim.play("Idle")
	
	# Turn off visibility on the instance of the instructions page scene, visibility is enabled when instructions page button is pressed
	instructionsPage.visible = false

# Button to make the debug level buttons visible. This will allow someone to play all levels irregardless of completing previous levels
func _on_unlock_debug_buttons_button_down():
	debugButtons.visible = true

# Button to change the scene to the home/initial game page
func _on_backto_home_button_down():
	get_tree().change_scene_to_file("res://my_world.tscn")

# Button to change the scene to play the game from level 1
func _on_level_1_button_down():
	get_tree().change_scene_to_file("res://Level 1/floor5.tscn")

# Button to change the scene to level 2
func _on_level_2_button_down():
	get_tree().change_scene_to_file("res://Level 2/Floor 4.tscn")

# Button to change the scene to level 3
func _on_level_3_button_down():
	get_tree().change_scene_to_file("res://Level 3/Floor 2.tscn")

# Button to change the scene to level 4
func _on_level_5_button_down():
	get_tree().change_scene_to_file("res://Level 5/Floor 1.tscn")

# Change the scene to the inventory page when the "Inventory" button is pressed
func _on_inventory_button_down():
	var pathname = get_scene_file_path()
	inventory.set_prev_page(pathname)
	get_tree().change_scene_to_file("res://Inventory/Inventory.tscn")

# Button to change the scene to the level navigation page
func _on_level_menu_button_down():
	get_tree().change_scene_to_file("res://Level Navigation/level_select.tscn")

# Button to change the scene to level 1 to play from the first level
func _on_play_button_down():
	get_tree().change_scene_to_file("res://Level 1/floor5.tscn")

# Button to open the instructions page. Turn on visibility on the instantiation node for the instruction scene
func _on_instructions_button_down():
	instructionsPage.z_index = 4
	instructionsPage.visible = true
