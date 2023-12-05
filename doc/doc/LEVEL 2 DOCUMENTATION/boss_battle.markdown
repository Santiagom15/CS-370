# boss_battle.gd

## Overview

The `boss_battle.gd` script extends the `CharacterBody2D` class in the Godot game engine. It is designed to implement attack actions for an enemy character, including a ray cast for detecting the player and a finite state machine for controlling behavior.

## Properties

### `ray_cast`

- Type: RayCast2D
- Description: A reference to the RayCast2D node used for detecting the player.

### `player`

- Type: Node
- Description: A reference to the player node, obtained by finding the child node named "player" from the parent.

### `machine`

- Type: FiniteStateMachine
- Description: A reference to the FiniteStateMachine node responsible for managing the enemy's behavior states.

### `direction`

- Type: Vector2
- Description: A vector representing the current direction the enemy is facing. Initialized to `Vector2.RIGHT`.

## Methods

### `_process(_delta)`

```gdscript
func _process(_delta):
    direction = (player.position - global_position).normalized()
    ray_cast.target_position = direction * 400
    var state = machine.current_state
```
This method calculates the direction vector from the enemy to the player, normalizes it, and then updates the `ray_cast` target position accordingly. 
It obtains the current state using the finite state machine (`machine`).

## Usage 
To use this script, attach it to an enemy character node in your Godot scene. Ensure that the necessary dependencies, such as the RayCast2D, player node, and FiniteStateMachine, are properly set up.