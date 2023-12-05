# Level changes.gd

## Overview

The `Level changes.gd` script handles level transitions and interactions in a 2D platformer game. It is responsible for changing scenes when the player enters specific areas, clearing data during transitions, and managing the visibility of an instructions page.

**Purpose**: This script manages level transitions, data clearing, and instructions page visibility in the game.

## Properties

### `inventory`

- Type: Node2D
- Description: A reference to the global inventory system that stores data across all scenes in the game.

### `instructionsPage`

- Type: Node2D
- Description: An instance of the instructions page scene. It toggles visibility when the player enters the "Instructions" doorway/detection shape.

## Methods

### `_ready()`

```gdscript
func _ready():
	# Disable visibility on the instructions page
	instructionsPage.z_index = 3
	instructionsPage.visible = false
	var player = get_parent().get_node("Player")
	player.position = Vector2(-247, -136)
```
This method is called when the scene loads. It sets the initial state of the instructions page by disabling its visibility and repositioning the player character.

### `clear_data_transition(transition_level)`

```gdscript
func clear_data_transition(transition_level):
	if inventory.get_current_level() != transition_level:
		inventory.clear_level_data()
```
This method clears level data if the player is transitioning to a different level.

### `_on_home_page_body_entered(body)`

```gdscript
func _on_home_page_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://first_game.tscn")
```
This method is triggered when the player enters the "Home Page" area. It changes the scene to the main game scene.

### `_on_inventory_page_body_entered(body)`

```gdscript
func _on_inventory_page_body_entered(body):
	if body.name == "Player":
		# Set the previous scene to the current scene so that we can return here after opening the Inventory scene
		var pathname = get_parent().get_scene_file_path()
		inventory.set_prev_page(pathname)
		get_tree().change_scene_to_file("res://Inventory/Inventory.tscn")
```
This method is triggered when the player enters the "Inventory Page" area. It sets the previous scene and changes the scene to the inventory scene.

### `_on_level_1_body_entered(body)`
### `_on_level_2_body_entered(body)`
### `_on_level_3_body_entered(body)`
### `_on_level_4_body_entered(body)`

These methods are triggered when the player enters specific level areas (Level 1, Level 2, Level 3, and Level 4). They clear data during transitions and change the scene to the corresponding level scene.

### `_on_instructions_body_entered(body)`

```gdscript
func _on_instructions_body_entered(body):
	if body.name == "Player":
		instructionsPage.z_index = 4
		instructionsPage.visible = true
```
This method is triggered when the player enters the "Instructions" area. It adjusts the z-index and visibility of the instructions page to make it visible.