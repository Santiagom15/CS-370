# NPC interaction office.gd

## Overview

The `NPC interaction office` script serves as a controller for managing the animations of a group of non-dialogue, interactive frog animated sprites. This group of NPCs does not have any dialgoue and does not have any keyboard interactions with the player, but when the player enters the detection space surrounding the Frog NPCs, they will start doing the "Blink" animation, as if they are looking at the player. Then the player is not in range, the frogs play the "Idle" animation starting at random frame numbers. This script is very similar to the `NPC interaciton bathroom` script but this script handling frog flipping. 

## Properties

### `frog_parent`

- Type: Node
- Description: A reference to the parent node containing frog sprites. Obtained using `get_node("Frog")`.

### `frog_child`

- Type: AnimatedSprite2D
- Description: A reference to the current frog child being processed in the animations.

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

NOTE: The methods and logic are the very similar to `NPC interaction bathroom.gd script`. The only difference is that there are two collision shapes and based on which one the player is in, that determines which direction (using the set_flip_h(boolean) function) the frogs will look