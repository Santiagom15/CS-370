# NPC interaction bathroom.gd

## Overview

The `NPC interaction bathroom` script serves as a controller for managing the animations of a group of non-dialogue, interactive frog animated sprites. This group of NPCs does not have any dialgoue and does not have any keyboard interactions with the player, but when the player enters the detection space surrounding the Frog NPCs, they will start doing the "Blink" animation, as if they are looking at the player. Then the player is not in range, the frogs play the "Idle" animation starting at random frame numbers.

## Properties

### `frog_parent`

- Type: Node2D
- Description: A reference to the parent node of all the Animatedrite2D nodes which act as the frog NPCs.

### `frog_child`

- Type: AnimatedSprite2D
- Description: A reference to the current frog child node.

### `num_frog_frames`

- Type: int
- Description: The number of frames in the "Idle" animation for a single frog. Determined during initialization.

### `rng`

- Type: RandomNumberGenerator
- Description: A random number generator used for selecting random frames for the "Idle" animation.

### `rand_frame`

- Type: int
- Description: A variable to store the randomly selected frame number for the "Idle" animation.

## Methods

### `play_animation(animation_name)`

```gdscript
func play_animation(animation_name):
	for idx in range(frog_parent.get_child_count()):
		frog_child = frog_parent.get_child(idx)
		frog_child.play(animation_name)
		if animation_name == "Idle":
			rand_frame = int(rng.randf_range(0, num_frog_frames))
			frog_child.set_frame(rand_frame)
		else:
			frog_child.set_frame(0)
```
This method plays the animation "animation_name" for all frog sprites which are a child of frog_parent. When the animation is "Blink" (or any other animation), the animation starts at frame 0, but when the animation is "Idle" a random frame is generated.

### `_ready()`

```gdscript
func _ready():
	var frogFrames = frog_parent.get_child(0).get_sprite_frames()
	num_frog_frames = frogFrames.get_frame_count("Idle")
	
	play_animation("Idle")
	for idx in range(frog_parent.get_child_count()):
		frog_child = frog_parent.get_child(idx)
		if "Flipped" in frog_child.get_name():
			frog_child.set_flip_h(true)
```  
It initializes the number of frames in the "Idle" animation.  
It also plays the "Idle" animation for all frog children and flips the sprites horizontally if their name has "Flipped."


### `_on_player_detection_body_entered(body)`

```gcdscript
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		play_animation("Blink")
```
When the player enters the range of the frogs (enters the associated detection area), then the "Blink" animation is played.

### `_on_player_detection_body_exited(body)`

```gcdscript
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		play_animation("Idle")
```
When the player exits the range of the frogs (exits the associated detection area), then the "Idle" animation is played.