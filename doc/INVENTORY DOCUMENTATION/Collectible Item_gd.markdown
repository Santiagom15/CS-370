# CollectibleItem.gd

## Overview

The `CollectibleItem.gd` script is used to create collectible items in the game. When the player enters the detection shape of the item and presses the spacebar, it triggers an interaction animation and adds the item to the player's inventory. The script also handles preserving the collection state of the object when a level is exited prematurely. This script is attached to all instances of collectible items and is designed work for different collectible items based on the name of the nodes.
Check the code file for additional commentation/documentation.

**Purpose**: This script defines the behavior of collectible items, including player interaction, animation, and inventory management.

## Properties

### `ITEM`

- Type: String
- Description: The name of the item, such as "Key," "Frog," or "Candle." This name is used to identify the item and add it to the inventory.

### `player_detected`

- Type: Boolean
- Description: A flag that indicates whether the player is currently within the detection shape of the item.

### `item_collected`

- Type: Boolean
- Description: A flag that indicates whether the item has already been collected by the player. Once collected, the item cannot be collected again and becomes disabled.

### `animItem`

- Type: AnimatedSprite
- Description: A reference to the AnimatedSprite node responsible for the item's animation.

### `animSparkle`

- Type: AnimatedSprite
- Description: A reference to the AnimatedSprite node responsible for the sparkle animation.

### `collision`

- Type: CollisionPolygon2D
- Description: A reference to the CollisionPolygon2D node representing the item's collision shape.

### `inventory`

- Type: Node2D
- Description: A reference to the game-wide collectible items inventory system used to store item counts.

### `levelRoot`

- Type: Node2D
- Description: A reference to the root node of the level scene.

### `itemNameUnique`

- Type: String
- Description: A unique identifier for the item's parent node in the level scene.

## Methods

### `_ready()`

```gdscript
func _ready():
    # Initialize item animations and visibility
    animItem.show()
    animItem.set_frame(0)
    animItem.play("Idle")

    animSparkle.hide()
    animSparkle.set_frame(0)

    levelRoot.itemDisabled.connect(_on_item_disabled)
```
This method is called when the scene loads. It initializes the item's animations and sets up signal connections for item disabling.

### `_process(delta)`

This method is called in every frame. It checks for player interaction with the item and triggers item collection animations and inventory updates when the player interacts with the item.

### `_on_animated_sparkle_animation_finished()`

This method is called when the sparkle animation has finished playing. It hides the sparkle animation.

### `_on_animated_item_animation_finished()`

This method is called when the item collection animation has finished playing. It hides the item animation.

### `_on_player_detection_item_body_entered(body)`

This method is triggered when the player's body enters the detection shape of the item. It updates the player_detected flag to true.

### `_on_player_detection_item_body_exited(body)`

This method is triggered when the player's body exits the detection shape of the item. It updates the player_detected flag to false.

### `_on_item_disabled(itemIdx)`

This method is called when the item has been disabled due to collection. It updates the item_collected flag to true and hides the item's animations and collision shape.