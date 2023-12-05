# bossRoom_Floor1.gd

## Overview

The `bossRoom_Floor1.gd` script extends the `Node2D` class in the Godot game engine. It manages the player's health, updating a health bar based on hits taken.

## Properties

- `global_var`: A reference to the global variable node located at "/root/Global."
- `curr_health`: Current health points, initialized to 6.
- `Healthbar`: Reference to the health bar node located at "$player/Camera2D2/HealthBar."
- `timmy`: Reference to the AudioStreamPlayer2D node located at "$AudioStreamPlayer2D."
- `healtharr`: An array representing different health values corresponding to hits.

## Methods

### `_ready()`

This method is called when the node enters the scene tree for the first time.
It initiates the restart of hits in the global variable.

### `_process(delta)`

This method is called every frame and retrieves the time from the `timmy` AudioStreamPlayer2D.
It also updates the health bar based on the current hits from the global variable.

