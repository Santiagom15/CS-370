# Exit boss 1 to level 1.gd

## Overview
The `Exit boss 1 to level 1` script extends the `Area2D` class in the game engine. It detects when the player collides with the collision box at the end of the escape stairwell in the exploration portion of the level. When a collision is detected, the scene changes to the exploration portion for the next level, level 1.

## Methods
**`_on_player_detection_body_entered(body)`**  

```gdscript
@onready var inventory = get_node("/root/Inventory")

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		# Clear all relevant level data to transition to next scene
		inventory.clear_level_data()
		# Change the scene to the next floor
		get_tree().change_scene_to_file("res://Level 2/Floor 4.tscn")
```
This method is connected to the built in GoDot `body_entered` signal of the "Player detection" collision shape.  
The signal is triggered when the player enters the collision shape and the scripting checks if the colliding node is named "Player".  
If true, the scene is changed to Level 2/Floor 4.