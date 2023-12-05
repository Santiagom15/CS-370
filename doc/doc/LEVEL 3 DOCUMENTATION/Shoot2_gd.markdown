# Shoot.gd

## Overview 

The 'Shoot' script extends `Node2D` class. This script is designed to handle the "shoot" behavior and provides functions for playing the attack animation. This battle is slightly different as we did not utilize the Finite State Machine script but implemented the same concept.

# Properties

- `player`: A reference to the player node in the `bossbattle2` scene.
- `flasky_node`: Loaded the attack object flask scene.
- `tim`: A reference to the Timer node to control time between attacks. 
- `shoot_stat`: A boolean to control if boss is in shoot state or not. Initialized to true.


## Methods

**`_process(_delta)`**  
This method handles the time between attacks by restarting the timer when it runs out.  

**`shoot()`**  
When this method is called, flasky attacks are instantiated, positioned relative to the boss sprite, and directed towards the position of the player.

**`_on_timer_timeout()`**  
When the Timer runs out, shoot() method is called to attack if the boss is in the shoot state given by `shoot_stat` variable.