# MeteorAttack.gd

## Overview

The `MeteorAttack.gd` script extends the `SantisBossesState` class in the Godot game engine. It represents a state where the Santis Boss performs a meteor attack. The script utilizes a timer for timing the meteor attacks and includes logic to shoot meteors in the specified direction.

## Properties

### `meteorNode`

- Type: PackedScene
- Description: A packed scene representing the meteor object to be instantiated during the meteor attack.

### `timer`

- Type: Timer
- Description: A reference to the `MeteroShoot` timer node, responsible for timing the meteor attacks.

## Methods

### `transition()`
This method handles transitions to other states

### `enter()`
This method is called when the state is entered.  
It called the method of the parent class `SantisBossesState`.  
Starts a timer to initiate the meteor attacks.

### `exist()`
This method is called when the state is exited. It stops the timer to halt the meteor attacks.

### `_on_metero_shoot_timeout()`
This method is connected to the `timeout` signal of the `MeteroShoot` timer.  
It is triggered when the timer reaches the timeout. 

### `shoot()`
This method handles instantiating and shooting meteor objects from the `meteorNode` packed scene.  
It sets the position of the meteor to the current global positition of the state.  
It also aims the direction of the meteor to the current global position of the player. 


