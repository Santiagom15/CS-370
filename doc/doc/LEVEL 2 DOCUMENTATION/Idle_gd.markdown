# Idle.gd

## Overview

The `Idle.gd` script extends the `SantisBossesState` class. It represents the idle state for the Santi's Boss character. This state is responsible for playing the idle animation and transitioning to the "MeteorAttack" state when a certain condition is met.

## Class Definition

```gdscript
extends SantisBossesState
class_name Idle
```

## Properties 
## `timer`
Type: Timer  
Description: A reference to the TestTimerFoMeteor node. This timer is used for handling attacks, and there's a note to address restoration or connection to a song for future implementation.  

## Methods
## `transition()`
This method takes care of transitioning to new states.
It checks if the `ray_cast` is colliding and if it is, then changes the state to `"MeteorAttack"`
## `animation()`
This method plays the "idle" animation using the `animator` object.  

## Usage
To use this script, attach it to a node that represents the boss character. 

