# story_indtroduction_page.gd

## Overview

The `story_indtroduction_page.gd` script controls the behavior of the story introduction page in the game. This page plays a logo animation and allows the player to continue to the menu or page-navigation scene by pressing the "Continue" button. It displays text that explains the background and higher-level overview of the game.

**Purpose**: This script manages the introduction and scene transition for the game's story introduction page.

## Methods

### `_ready()`

```gdscript
func _ready():
	# Play the idle animation for the game logo
	var logoAnim = get_node("Arrythmia logo animation")
	logoAnim.play("Idle")
```
This method is called when the scene loads. It plays the "Idle" animation for the game logo.

### `_on_continue_button_button_down()`

```gdscript
func _on_continue_button_button_down():
	get_tree().change_scene_to_file("res://first_game.tscn")
```
This method is triggered when the "Continue" button is pressed. It changes the scene to the main menu or page-navigation scene by loading the "first_game.tscn" scene file.