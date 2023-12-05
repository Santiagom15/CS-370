# MenuPageButtonNavigation.gd

## Overview

The `MenuPageButtonNavigation.gd` script is responsible for managing the behavior of the main game menu, allowing the player to access various game levels, open the inventory, and view instructions.

## Properties

### `debugButtons`

- Type: Node2D
- Description: Parent node for debug level buttons that allow direct access to levels without needing to unlock them through previous level completion.

### `idleAnims`

- Type: Node2D
- Description: Parent node for all idle animations in the scene.

### `instructionsPage`

- Type: Node2D
- Description: Instance of the instructions page scene. Visibility is toggled when the user presses the "Instructions" button.

### `inventory`

- Type: Node2D
- Description: Global inventory system used to store data between scenes.

## Methods

### `_ready()`

```gdscript
func _ready():
	# Turn off the visibility on the debug level buttons so they cannot be easily accessed
	debugButtons.visible = false
	for child_idx in range(get_child_count()):
		var anim = idleAnims.get_child(child_idx)
		anim.play("Idle")
	
	# Turn off visibility on the instance of the instructions page scene, visibility is enabled when instructions page button is pressed
	instructionsPage.visible = false
```
This method is called when the scene loads. It initializes the scene by hiding debug level buttons and playing idle animations. It also hides the instructions page.

### `_on_unlock_debug_buttons_button_down()`
Button to make the debug level buttons visible. This will allow someone to play all levels irregardless of completing previous levels.

### `_on_backto_home_button_down()`
Button to change the scene to the home/initial game page

### `_on_level_1_button_down()`
Button to change the scene to play the game from level 1

### `_on_level_2_button_down()`
Button to change the scene to play the game from level 2

### `_on_level_3_button_down()`
Button to change the scene to play the game from level 3

### `_on_level_4_button_down()`
Button to change the scene to play the game from level 4

### `_on_inventory_button_down()`
Change the scene to the inventory page when the "Inventory" button is pressed

### `_on_level_menu_button_down()`
Button to change the scene to the level navigation page

### `_on_play_button_down()`
Button to change the scene to level 1 to play from the first level

### `_on_instructions_button_down()`
Button to open the instructions page. Turn on visibility on the instantiation node for the instruction scene