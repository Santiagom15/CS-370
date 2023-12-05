# HealthBar.gd

## Overview

The `HealthBar.gd` script extends the `AnimatedSprite2D` class in the Godot game engine. It is designed to serve as an indicator for the player's heath bar indicator's position on the screen. The script utilizes the `get_parent()` method to obtain a reference to the parent node, assumed to be the camera.

## Properties

### `camara`

- Type: Node
- Description: A reference to the parent node, assumed to be the camera. Obtained using `get_parent()`.

## Methods

### `_physics_process(_delta)`

```gdscript
# Called every physics frame.
func _physics_process(_delta):
    print(camara.get_screen_center_position)
    position = camara.get_screen_center_position() - Vector2(400, 200)
    #print(camara.postion,"Relative position ",global_position)
```

