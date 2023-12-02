extends Node2D

# Get game wide inventory
@onready var inventory = get_node("/root/Inventory")

# Array storing the file paths to the current boss battle scene and the current explortation level associated with that boss battle
var paths = ["", ""]

func _ready():
	
	# Store the paths of the current boss battle and level based on level data stored in the inventory
	var curr_level = inventory.get_current_level()
	print("-curr_level: ", curr_level)
	if curr_level == "res://Level 1/floor5.tscn":
		paths[0] = "res://Level 1/bossbattle_floor5.tscn"
		paths[1] = "res://Level 1/floor5.tscn"
		print("-paths: ", paths)
	elif curr_level == "res://Level 2/Floor 4.tscn":
		paths[0] = "res://bossbattle2/bossbattle2.tscn"
		paths[1] = "res://Level 2/floor4.tscn"
		print("-paths: ", paths)

# When the "Replay battle" button is pressed, change scene to the current boss battle scene
func _on_restart_battle_button_down():
	get_tree().change_scene_to_file(paths[0])

# When the "Return to level" button is pressed, change scene to the current level scene
func _on_restart_level_button_down():
	get_tree().change_scene_to_file(paths[1])
