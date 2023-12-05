# Opening scene.gd

## Overview

The `Opening scene.gd` script controls the behavior of the opening scene in the game. This scene includes an animated logo and provides functionality to start the game or exit the application.

**Purpose**: This script manages the behavior of the opening scene, allowing players to start the game or exit the application.

## Methods

### `_ready()`

```gdscript
func _ready():
	var animLogo = get_node("Background graphics").get_node("Arrythmia logo animation")
	animLogo.play("Idle")
	animLogo.set_frame(0)
```
This method is called when the scene loads. It plays the "Idle" animation for the game logo and sets its frame to the initial frame (frame 0).

### `_on_exit_button_down()`

```gdscript
func _on_exit_button_down():
	get_tree().quit()
```
This method is triggered when the "Exit" button is pressed. It quits the game/application.

### `on_start_button_down()`
```gdscript
func _on_start_button_down():
	get_tree().change_scene_to_file("res://Level Navigation/story_introduction_page.tscn")

```
This method is triggered when the "Start" button is pressed. It changes the scene to the story introduction page by loading the "story_introduction_page.tscn" scene file.