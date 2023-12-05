# Floor 4 to floor 2.gd

## Overview
The `Floor 4 to floor 2` script detects when the player collides with the collision box at the end of the escape stairwell to transition to the next level. When a collision is detected, the scene changes to the exploration portion for level 3.

## Properties

### `inventory`

- Type: `Node2D`
- Description: Retrieves the game wide inventory scripting that stores data across all scenes in the game, such as items collected, interactions unlocked, status of current boss battle, player position, and more.

## Methods

###`_on_player_detection_body_entered(body)` 

```gdscript
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		inventory.clear_level_data()
		get_tree().change_scene_to_file("res://Level 3/Floor 2.tscn")
```
When any collision shape collides with the associated player detection node (the Area2D node with CollisionShape2D child node with biult-in GoDot signal body_enter() connected to this script) this function is called. When the colliding object is the player node, then the scene is changed to the next level scene. Also, all relevant data in the inventory associated with the current scene is cleared. In particular, the location of the player, items collected, interactions unlocked, and boss battle win status.