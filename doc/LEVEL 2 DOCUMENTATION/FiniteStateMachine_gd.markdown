# FiniteStateMachine.gd

## Overview

The `FiniteStateMachine` script extends the `Node2D` class in the Godot game engine. It is designed to manage finite states for a character, particularly tailored for the Santis Bosses.

## Class Definition

```gdscript
extends Node2D
class_name FiniteStateMachine
```
The script extends the Node2D class, indicating that it inherits functionality from the parent class.

## Properties 

`current_state`
Type: `SantisBossesState`
Description: Represents the current state of the finite state machine.
`previous_state`
Type: `SantisBossesState`
Description: Represents the previous state before a state change.

## Methods
## `_ready()`
```gdscript

func _ready():
    print(get_child(0).to_string())
    current_state = get_child(0) as SantisBossesState 
    previous_state = current_state
    current_state.enter()
```
This method is automatically called when the node enters the scene tree for the first time.
It initializes the `current_state` and `previous_state` properties.  
Retrieves the first child node and assigns it as the initial state.  
Calls the `enter()` method on the current state.  
change_state(state)


````gdscript

func change_state(state):
    current_state = find_child(state) as SantisBossesState
    current_state.enter()

    previous_state.exit()
    previous_state = current_state
````
This method allows you to change the state of the finite state machine.  
It finds the child node with the specified state name and assigns it as the new current state.  
Calls the `enter()` method on the new current state.  
Calls the `exit()` method on the previous state.  
Updates the previous_state property with the current state.

## Usage
To use the `FiniteStateMachine` script, attach it to a node in your Godot scene that represents a character with different states. Ensure that the child nodes representing different states extend the SantisBossesState class.