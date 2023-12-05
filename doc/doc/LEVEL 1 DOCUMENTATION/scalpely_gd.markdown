# scalpely.gd

## Overview

The `scalpely.gd` script extends the `Node2D` class and represents the scalpel attack with a specific animation and logic for damaging the player. The script also includes functionality to handle the destruction of the attack when it goes off-screen or hits the player.

## Properties

### `direction`
A vector representing the direction of the attack. Initialized to `Vector2.DOWN`.

### `speed`
The speed at which the attack moves.

### `explodeTimer`
A reference to a Timer node used to fix the time for the scalpel exploding animation.

### `global_hit`
A reference to the global `Global` node (`/root/Global`), used for managing global variables.

## Methods

### `_physics_process(delta)`
This method updates the position of the attack area based on the specified direction and speed.


### `_on_hit_box_body_entered(body)`
This method is connected to the `body_entered` signal and is triggered when the attack area collides with the body.  
It checks if the colliding node is named "player."  
If true, it incrememnts the global hits variable and plays the exploding animation.

### `__on_explode_timer_timeout()`
After the scalpel exploding animation plays, it is removed from the scene. 