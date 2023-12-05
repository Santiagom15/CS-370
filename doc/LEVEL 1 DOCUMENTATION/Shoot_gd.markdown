# Shoot.gd

## Overview 

The 'Shoot' script extends 'State' class. This script is designed to handle the "shoot" state behavior. 'Shoot.gd' provides functions for transitioning to other states and playing the attack animation. 

## Class Definition 

```gdscript  
extends State  
class_name ShootState  
```

## Properties

- `scalpely_node`: An export of the 'scalpely' scene. 
- `timer`: A reference to the Timer node to fix the time between attacks.


## Methods

**`transition()`**  
This method handles transitioning the entity to the "idle" state when the ray case is not colliding with any other objects.  

**`enter()`**  
This method can be called to enter the Shoot state. 

**`exit()`**  
This method can be called to exit the Shoot state. 

**`shoot()`**  
When this method is called, scalpely attacks are instantiated, positioned relative to the boss sprite, and directed down towards the player.

**`_on_timer_timeout()`**  
When the Timer runs out, shoot() method is called to attack.
