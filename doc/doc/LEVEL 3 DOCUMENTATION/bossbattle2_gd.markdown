# bossbattle2.gd

## Overview

The `bossbattle2.gd` script extends the `Node2D` class in the Godot game engine. It manages the gameplay and player's health, updating a health bar based on hits taken.

## Properties

- `global_var`: A reference to the global variable node located at "/root/Global."
- `spikeTimer`: A reference to the spikeTimer node which will fix the frequency of the spike attacks.

- `timmy`: A reference to the AudioStreamPlayer2D node in the scene.

- `spike_node`: Loading the spike animation scene.

- `curr_health` : The current health of the player character. Initialized to `6`.

- `health`: A reference to the HealthBar node in the scene.

- `healtharr`: An array representing different health values corresponding to the player's hits. Used for managing the player's health progression.

## Methods

### `_ready()`

This method is called when the node enters the scene tree for the first time.
It initiates the restart of hits in the global variable.

### `_on_timer_timeout()`

Signal by the Timer, when the music ends and battle is won, boss and attacks disappear. A key appears for the player to collect. 

### `_process(delta)`

This method is called every frame and retrieves the time from the `timmy` AudioStreamPlayer2D.
It also updates the health bar based on the current hits from the global variable.
It sets the spike spawing pattern by calling `spiked()` every 5 seconds and changes the visibility of the warning dots.  

### `spiked()`

When the method is called, the `spike` scene is instantiated inthe current `testscene`.
