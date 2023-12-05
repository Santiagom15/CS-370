# Instructions page script.gd

## Overview

The `InstructionsPageScript.gd` script controls the behavior of an instructions page in the game game. This instructions page can be instantiated through nodes in other scenes. When the player presses the "Instructions" button, an instance of the instructions page becomes visible. The page can be made non-visible again when the "Close" button within the instructions page is pressed. Unlike the inventory page, the scene is not changed when the player chooses to look at the instructions page, instead the visibility of an instance of thhe instructions page is toggled on and off.

**Purpose**: This script manages the visibility and animations of an instructions page in the game.

## Properties

### `instructionsPage`

- Type: Node2D
- Description: A reference to the parent node that contains all nodes for this instructions page.

### `anims`

- Type: Node2D
- Description: A reference to the parent node that contains all animation graphics nodes.

## Methods

### `_ready()`

```gdscript
func _ready():
	# Play all idle animations for each of the animation nodes in the scene
	for child_idx in range(anims.get_child_count()):
		var currAnim = anims.get_child(child_idx)
		currAnim.play("Idle")
		currAnim.set_frame(0)
```
This method is called when the scene loads. It plays the "Idle" animation for all animation nodes in the scene and sets their frames to the initial frame (frame 0).

### `_on_close_button_button_down()`

```gdscript
func _on_close_button_button_down():
	self.visible = false
```
This method is triggered when the "Close" button is pressed. It makes all nodes in the scene invisible by setting the visibility of the script's parent node to false.