extends Node2D

@onready var inventory = get_node("/root/Inventory")

# Instance of the instructions page scene. Toggle visibility when user enters the "Insutrctions" doorway/detection shape
@onready var instructionsPage = get_parent().get_node("Player").get_node("Instructions page")

func _ready():
	# Disable visibility on the instructions page
	instructionsPage.z_index = 3
	instructionsPage.visible = false
	var player = get_parent().get_node("Player")
	player.position = Vector2(-247, -136)


func clear_data_transition(transition_level):
	if inventory.get_current_level() != transition_level:
		inventory.clear_level_data()


func _on_home_page_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://first_game.tscn")


func _on_inventory_page_body_entered(body):
	if body.name == "Player":
		# Set the previous scene to the current scene so that we can return here after opening the Inventory scene
		var pathname = get_parent().get_scene_file_path()
		inventory.set_prev_page(pathname)
		get_tree().change_scene_to_file("res://Inventory/Inventory.tscn")


func _on_level_1_body_entered(body):
	if body.name == "Player":
		clear_data_transition("res://Level 1/floor5.tscn")
		get_tree().change_scene_to_file("res://Level 1/floor5.tscn")


func _on_level_2_body_entered(body):
	if body.name == "Player":
		clear_data_transition("res://Level 2/Floor 4.tscn")
		get_tree().change_scene_to_file("res://Level 2/Floor 4.tscn")


func _on_level_3_body_entered(body):
	if body.name == "Player":
		clear_data_transition("res://Level 3/Floor 2.tscn")
		get_tree().change_scene_to_file("res://Level 3/Floor 2.tscn")


func _on_level_4_body_entered(body):
	if body.name == "Player":
		clear_data_transition("res://Level 5/Floor 1.tscn")
		get_tree().change_scene_to_file("res://Level 5/Floor 1.tscn")


func _on_instructions_body_entered(body):
	if body.name == "Player":
		instructionsPage.z_index = 4
		instructionsPage.visible = true
