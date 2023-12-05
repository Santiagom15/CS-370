# Initial info.gd

## Overview

The `Initial info.gd` script manages a speech bubble and associated text for in-game speech. When the player enters the detection area, the speech bubble and text become visible. When the player exits the detection area, they are hidden. The speech nodes contain instructions and suggestions for the player at the start of every exploration portion of a level.

## Properties

### `speech`

- Type: Node2D
- Description: A reference to the parent node containing the speech bubble and text nodes.

### `speechBubble`

- Type: Node2D
- Description: A reference to the speech bubble node, which represents the graphical speech bubble.

### `speechText`

- Type: Label
- Description: A reference to the Label node used for displaying speech text within the speech bubble.

## Methods

### `_ready()`

```gdscript
func _ready():
    speechBubble.z_index = 2
    speechText.z_index = 2
```
This method is called when the scene loads. It sets the z-index of the speech bubble and speech text to 2, ensuring that they are rendered above other elements in the game.

### `_on_player_detection_body_exited(body)`

This method is triggered when the player's body exits the detection area. It hides both the speech bubble and speech text nodes, making them invisible to the player.

### `_on_player_detection_body_entered(body)`

This method is triggered when the player's body enters the detection area. It shows both the speech bubble and speech text nodes, making them visible to the player.