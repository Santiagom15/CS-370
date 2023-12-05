# bossRoom_Floor1.gd

## Overview

The `bossbattle_floor5.gd` script extends the `Node2D` class in the Godot game engine. It manages the player's health, updating a health bar based on hits taken.

## Properties

- `global_hit`: A reference to the global variable node located at "/root/Global."
- `deathTimer`: A reference to the deathTimer node which will keep track of time after the player dies.
- `state`: Reference to the Shoot state node located in the boss scene.
- `timmy`: Reference to the AudioStreamPlayer2D node located at "$AudioStreamPlayer2D."
- `newPos1, newPos2, newPos3`: Position of boss spawning places in the 3 respective lanes stored in array `poses`

## Methods

### `_ready()`

This method is called when the node enters the scene tree for the first time.
It initiates the restart of hits in the global variable.

### `_on_timer_timeout()`

Signal by the Timer, when the music ends and battle is won, boss and attacks disappear. A key appears for the player to collect. 

### `_process(delta)`

This method is called every frame and retrieves the time from the `timmy` AudioStreamPlayer2D.
It also updates the health bar based on the current hits from the global variable.
It also randomizes the boss spawning pattern among the three lanes and ensures the boss doesn't spawn thrice in a row in the same lane. 

### `_on_death_timer_timeout()`

Signal by a Timer node, when the player dies (battle is lost), the game stops for a few seconds and switches to a Lost Scene.
