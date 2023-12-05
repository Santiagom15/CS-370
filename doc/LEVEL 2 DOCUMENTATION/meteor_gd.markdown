# meteor.gd

## Overview

The `meteor.gd` script extends the `Area2D` class and represents an enemy attack area with a specific animation and logic for damaging the player. The script also includes functionality to handle the destruction of the attack area when it goes off-screen.

## Properties

### `direction`

- Type: Vector2
- Description: A vector representing the direction of the attack. Initialized to `Vector2.RIGHT`.

### `speed`

- Type: int
- Description: The speed at which the attack area moves.

### `animation`

- Type: AnimatedSprite2D
- Description: A reference to the `AnimatedSprite2D` node used for playing the attack animation.

### `global_var`

- Type: Node
- Description: A reference to the global `Global` node (`/root/Global`), used for managing global variables.

## Methods

### `_ready()`
This method is called when the node initially enters the scene. It initiates the "Attack1" animation.  
### `_physcics_process(delta)`
This method updates the position of the attack area based on the specified direction and speed.

### `_on_visible_on_screen_notifier_2d_screen_exited()`
This method is connected to the `screen_exited` signal of the `VisibleOnScreenNotifier2D` and it is triggered when the attack area goes off-screen.

### `_on_body_entered(body)`
This method is connected to the `body_entered` signal and is triggered when the attack area collides with the body.  
It checks if the colliding node is named "player."  
If true, it incrememnts the global hits variable and changes the scene to the death screen: `deathscene.tscn` if the hits exceed or are equal to 6.