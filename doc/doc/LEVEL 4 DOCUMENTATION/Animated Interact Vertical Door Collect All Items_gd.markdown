# Animated Interact Vertical Door Collect All Items.gd

## Overview

The `Animated Interact Vertical Door Collect All Items.gd` script manages the behavior of a door. The implementation of this vertical locked door is extremely similar to that of the original locked vertical door except that the door is unlocked when a certain number of items exist in the current level's inventory. This is used on level 4 exploraiton portion where the player must collect all collectible items in the scene to open the door to enter the boss battle room. It controls the opening and closing of the door based on player interactions, player position, and item collection status. The script also handles animations and collision shapes for the door.

**Purpose**: This script controls the interaction and state of the entrance door to the boos battle room in level 4 where the player must collect all items in the scene to unlock the door.

## Properties

### `collDoor`

- Type: `CollisionShape2D`
- Description: A reference to the collision shape of the closed door.

### `detectLeft` and `detectRight`

- Type: `CollisionShape2D`
- Description: Collision shapes used as detection areas for player interaction when approaching the door from the left or right sides.

### `animRight` and `animLeft`

- Type: `AnimationPlayer`
- Description: Animation players used for animating the door opening and closing to the right or left.

### `collTopLeft` and `collTopRight`

- Type: `CollisionShape2D`
- Description: Collision shapes used for the top part of the door when it's open to the left or right sides.

### `play_open`, `play_close`, `left_open`, `right_open`

- Type: Boolean
- Description: Logical variables recording the state of the door, whether it's in the process of opening, closing, or fully open to the left or right.

### `stack_approach_side`, `len`, `curr_side`

- Type: Array, Integer
- Description: A stack used to record the current and recent positions of the player relative to the door. It stores values of 0 (left) or 1 (right) to indicate the player's side.

### `inventory`

- Type: Node2D
- Description: Retrieves the game-wide inventory system that stores data across all scenes in the game, such as items collected and level unlocks.

### `unlocked`

- Type: Boolean
- Description: A logical flag indicating whether the door has been opened with the key item.

### `animKey` and `animSparkle`

- Type: AnimationPlayer
- Description: Animation players for the key and sparkle animations used when the door is unlocked.

### `total_num_key_frames`

- Type: Integer
- Description: Total number of frames in the key animation.

### `levelRoot`

- Type: Node2D
- Description: The parent node containing level-related information.

### `lockIdx` and `doorName`

- Type: Integer, String
- Description: Variables used to manage the state of locked doors and identify individual doors by their name.

## Methods

### `_ready()`

```gdscript
func _ready():
	animKey.z_index = 2
	animKey.hide()
	animRight.show()
	animLeft.show()
	animSparkle.hide()
	
	collTopLeft.set_deferred("disabled", true)
	collTopRight.set_deferred("disabled", true)
	
	# Start all animations at initial frame
	animKey.set_frame(0)
	animRight.set_frame(0)
	animLeft.set_frame(0)
	animSparkle.set_frame(0)
	
	levelRoot.lockDisabled.connect(_on_lock_disabled)
```
This method is called when the scene loads. It initializes various properties, hides and shows animation nodes, and sets up collision shapes. Additionally, it connects the lockDisabled signal to the _on_lock_disabled method.

### `_process(delta)`
```gdscript
func _process(delta):
	len = stack_approach_side.size()
	# Check if requirements are met and player has pressed the spacebar
	if play_open == true && len == 2 && Input.is_action_pressed("ui_accept"):
		# ...
		# Door opening logic goes here
		# ...```
This script is called every frame. It checks if the requirements for opening the door are met and handles player interactions to open the door.

### `_on_animated_sparkle_animation_finished()`
```gdscript
func _on_animated_sparkle_animation_finished():
	# ...
	# Door opening logic goes here
	# ...```
This method is called when the sparkle animation finishes. It continues the door opening logic based on the player's position and door state.


### `_on_lock_disabled(lockIdx)`
```gdscript
func _on_lock_disabled(lockIdx):
	# ...
	# Door unlocking logic goes here
	# ...```
This method is connected to the lockDisabled signal and handles unlocking the door when the player has the key item.

### `_on_animated_key_frame_changed()`
```gdscript
func _on_animated_key_frame_changed():
	# ...
	# Key animation logic goes here
	# ...```
This method is called when the key animation frame changes. It manages the key animation's transparency and visibility.

### `_on_PlayerDetectionFromRight_body_entered(body)`

```gdscript
func _on_PlayerDetectionFromLeft_body_entered(body):
	# ...
	# Door interaction logic goes here
	# ...
```
These methods update the door state when the player enters the left or right detection areas.

### `_on_PlayerDetectionFromRight_body_exited(body)``
```gdscript
func _on_PlayerDetectionFromLeft_body_exited(body):
	# ...
	# Door interaction logic goes here
	# ...
```
These methods update the door state when the player exits the left or right detection areas.

