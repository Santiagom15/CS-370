# BossBattleController.gd

## Overview

The `BossBattleController.gd` script is responsible for managing boss battle functionality after the player has lost the boss battle, allowing the player to replay the boss battle or return to the exploration level associated with that boss battle. This script is used by all boss battles.


## Properties

### `inventory`

- Type: Node2D
- Description: A reference to the game-wide inventory system used to store data between scenes.

### `paths`

- Type: Array (String)
- Description: An array storing the file paths to the current boss battle scene (index 0) and the current exploration level associated with that boss battle (index 1).

## Methods

### `_ready()`

```gdscript
func _ready():
	# Store the paths of the current boss battle and level based on level data stored in the inventory
	var curr_level = inventory.get_current_level()
	if curr_level == "res://Level 1/floor5.tscn":
		paths[0] = "res://Level 1/bossbattle_floor5.tscn"
		paths[1] = curr_level
	elif curr_level == "res://Level 2/Floor 4.tscn":
		paths[0] = "res://Level 2/bossRoom_Floor 4.tscn"
		paths[1] = curr_level
	elif curr_level == "res://Level 3/Floor 2.tscn":
		paths[0] = "res://bossbattle2/bossbattle2.tscn"
		paths[1] = curr_level
	elif curr_level == "res://Level 5/Floor 1.tscn":
		paths[0] = "res://Level 5/bossRoom_Floor1.tscn"
		paths[1] = curr_level
```
This method is called when the scene loads. It determines the file paths of the current boss battle scene and the associated exploration level based on level data stored in the inventory.

### `_on_restart_battle_button_down()`

```gdscript
func _on_restart_battle_button_down():
	get_tree().change_scene_to_file(paths[0])
```
This method is triggered when the "Replay Battle" button is pressed. It changes the scene to the current boss battle scene (index 0 in paths).

### `_on_restart_level_button_down()`

```gdscript
func _on_restart_level_button_down():
	get_tree().change_scene_to_file(paths[1])
```
This method is triggered when the "Return to Level" button is pressed. It changes the scene to the current exploration level associated with the boss battle (index 1 in paths).