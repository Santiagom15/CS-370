# Character Behavior Script

This script extends `CharacterBody2D` and controls the behavior of a character in a 2D game. It includes functionality for handling player input, playing animations, and updating visual elements based on various conditions.

## Variables

- `speed`: Global variable controlling character movement speed.
- `_animated_sprite`: Reference to the `AnimatedSprite2D` node for character animations.
- `heart`: Reference to the `Heart` node for heart animation.
- `timer`: Reference to the `Timer` node for managing time-based events.
- `press`: Reference to the `press` node.
- `background`: Reference to the `ColorRect` node for background color changes.
- `heartbeat`, `heartFrame`: Variables for heart-related animations.
- `space`: Flag indicating if the space key is pressed.
- `moving`: Flag indicating if the character is currently moving.
- `state`: Flag representing the current state.
- `accuracy`: Variable controlling the accuracy of background color changes.

## Methods

### `_ready()`

- Initializes the script.
- Starts the heart animation.
- Disables the `CanvasLayer` node for allowing mouse clicks on other nodes.

### `isSpacePressed() -> bool`

- Checks if the space key is pressed.
- Returns `true` if pressed, otherwise `false`.

### `_on_heart_frame_changed()`

- Callback function triggered when the heart frame changes.
- Prints the current state and input conditions.

### `test()`

- Test function printing the current state and input conditions.

### `get_input()`

- Handles player input.
- Sets the `moving` flag based on input direction.

### `_physics_process(_delta)`

- Main physics process function.
- Calls `get_input()`, `move_and_slide()`, and `checkingConditions()`.

### `_process(_delta)`

- Main process function.
- Plays animations based on key presses.

### `checkingConditions()`

- Checks and updates conditions based on movement and space key.
- Calls `calcAccuracy()`.

### `_on_timer_timeout()`

- Timer callback function.
- Toggles between light and dark frames for the heart animation.

### `calcAccuracy(accuracy: float)`

- Calculates accuracy and updates the background color.
- Darkens the background color based on accuracy.

