# NPC interaction.gd

## Overview

The `NPC interaction` script is responsible for managing the animations of a group of frog NPC sprites, allowing for dynamic changes in animation based on player interactions. This script relates to NPC frog interactions that do not involved dialogue. When the player walks into the detection area to the right of the frogs, the frogs look the way of the player and blink. When the player enters the detection area to the left, the frogs look to the left and blink. When the player exits the range of the frogs, they return to the idle ribbiting animation.

## Properties

### `frog_parent`

- Type: Node2D
- Description: A reference to the parent node containing frog sprites. The node is dynamically updated based on the player's position.

### `frog_child`

- Type: AnimatedSprite2D
- Description: A reference to the current frog child being processed in the animations.

### `frogRight`

- Type: String
- Description: A string identifier for the node containing frog sprites facing right.

### `frogLeft`

- Type: String
- Description: A string identifier for the node containing frog sprites facing left.

### `in_right`

- Type: bool
- Description: A boolean flag indicating whether the player is in the area associated with frogs facing right.

### `in_left`

- Type: bool
- Description: A boolean flag indicating whether the player is in the area associated with frogs facing left.

### `num_frog_frames`

- Type: int
- Description: The number of frames in the "Idle" animation for a single frog. Determined during initialization.

### `rng`

- Type: RandomNumberGenerator
- Description: A random number generator used for selecting random frames for the "Idle" animation.

### `rand_frame`

- Type: int
- Description: A variable to store the randomly selected frame for the "Idle" animation.

## Methods

### `set_flip(flip_bool, frogDirection)`
This method sets the horizontal flip state for all of the frog sprites in a specified direction.

### `play_animation(animation_name)`
This method plays specified animation for all frog sprites in both directions and for the "Idle" animation, it seletes a random frame for each frog.

### `ready()`
This method initializes the number of frames in the "Idle" animation and sets the inital flip states.  
It plays the "Idle" animation for both frog directions.

### `_on_player_detection_left_body_entered(body)`
This method is connected to the `body_entered` signal of the left player detection area and sets the flip states and plays the "Blink" animation when the player enters the left detection area.

### `_on_player_detection_left_body_exited(body)`
This method is connected to the `body_exited` signal of the left player detection area.
Sets the flip states and plays the "Idle" animation when the player exits the left detection area (if not in the right area).

### `_on_player_detection_right_body_entered(body)`
This method is connected to the `body_entered` signal of the right player detection area.
Sets the flip states and plays the "Blink" animation when the player enters the right detection area.

### `_on_player_detection_right_body_exited(body)`
This method is connected to the `body_exited` signal of the right player detection area.
Sets the flip states and plays the "Idle" animation when the player exits the right detection area (if not in the left area).


