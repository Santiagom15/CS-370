# Exit boss 1 to level 1.gd

## Overview
The `Exit boss 1 to level 1` detects when the player collides with the collision box just outside the exit doors to the level 1 boss battle room. When a collision is detected, the scene changes from the level 1 boss battle room scene to the level 1 exploration scene.

## Methods
**`_on_body_entered(body)`**  

```gdscript
func _on_body_entered(body):
	if body.name == "player":
		get_tree().change_scene_to_file("res://Level 1/floor5.tscn")
```
This method is connected to the built-in GoDot `body_entered` signal of the "Player detection" collision shape.  
The signal is triggered when the player enters the collision shape and the scripting checks if the colliding node is named "Player".  
If true, the scene is changed to Level 1/floor5.