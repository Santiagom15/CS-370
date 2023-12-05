# Inventory buttons.gd

# CloseButton.gd

## Overview

The `CloseButton.gd` script provides functionality for handling the "Close" button in the game's UI. When this button is pressed, the script retrieves the path of the previous scene and changes the current scene to that previous scene. This allows players to return to the previous screen or game state.

**Purpose**: This script facilitates navigation by allowing players to close a screen or return to a previous state in the game.

## Properties

### `inventory`

- Type: Node
- Description: A reference to the global inventory node located at "/root/Inventory." This node is used to retrieve information about the previous scene.

## Methods

### `_on_close_button_down()`

```gdscript
func _on_close_button_down():
    var previous_scene_path = inventory.get_prev_page()
    get_tree().change_scene_to_file(previous_scene_path)
```
This method is triggered when the "Close" button is pressed. It retrieves the path of the previous scene from the inventory using inventory.get_prev_page() and then uses get_tree().change_scene_to_file() to change the current scene to the previous scene's path.