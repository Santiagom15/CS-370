# Accessing locked levels and warning messages.gd

## Overview

The `Accessing locked levels and warning messages.gd` script manages locked levels and warning messages in the level navigation scene. It controls the interaction with locked levels, displays a warning message when the player approaches a locked level, and checks the player's progress in the game to enable or disable level access.

**Purpose**: This script controls the accessibility and warning messages of locked levels in the game for the level navigiation scene.

## Properties

### `level_num`

- Type: Integer
- Description: Stores the level number parsed from the script's node name.

### `col`

- Type: CollisionShape2D
- Description: A reference to the collision shape node used for detecting player interaction with the level.

### `speech`

- Type: Node2D
- Description: A node used for displaying warning messages when the player approaches a locked level.

### `detect`

- Type: CollisionShape2D
- Description: A collision shape used as a detection area for player proximity.

### `inventory`

- Type: Node2D
- Description: Retrieves the game-wide inventory system that stores data across all scenes in the game, such as unlocked levels and collected items.

## Methods

### `_ready()`

```gdscript
func _ready():
	speech.z_index = 2
	speech.hide()
	if inventory.get_level_number_unlocked() >= level_num:
		col.set_deferred("disabled", true)
		detect.set_deferred("disabled", true)
```
This method is called when the scene loads. It sets up the warning message node and checks if the current level is unlocked based on the player's progress in the game. If the level is unlocked, it disables collision and detection shapes.

# `_on_player_detection_body_entered(body)`

```func _on_player_detection_body_entered(body):
	if body.name == "Player":
		speech.show()
```
This method is triggered when the player enters the detection area. It displays the warning message if the detected body is the player.

# `_on_player_detection_body_exited(body)`
```func _on_player_detection_body_exited(body):
	if body.name == "Player":
		speech.hide()
```
This method is triggered when the player exits the detection area. It hides the warning message if the detected body is the player.