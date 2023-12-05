# Boss to Floor 2.gd

## Overview
The `Boss to Floor 2` script detects when the player collides with the collision box just outside the exit doors of the level 3 boss battle room. When a collision is detected, the scene changes to the exploration portion for level 3.

## Methods
###`_on_player_detection_body_entered(body)` 

```gdscript
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Level 3/Floor 2.tscn")
```
This method is connected to the built in GoDot `body_entered` signal of the "Player detection" collision shape.  
The signal is triggered when the player enters the collision shape and the scripting checks if the colliding node is named "Player".  
If true, the scene is changed to Level 3/Floor 2.