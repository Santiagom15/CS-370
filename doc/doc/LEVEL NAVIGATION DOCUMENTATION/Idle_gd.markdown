# Idle.gd

## Overview

The `Idle.gd` script plays all idle animations, AnimatedSprite2D nodes, in the level navigation scene as soon as the scene loads.

## Methods

### `_ready()`

```gdscript
func _ready():
	self.set_frame(0)
	self.play("Idle")
```
This method is called when the scene loads and plays the "Idle" animation (which is played on loop) for the Animatedrite2D node that the script is attached to.