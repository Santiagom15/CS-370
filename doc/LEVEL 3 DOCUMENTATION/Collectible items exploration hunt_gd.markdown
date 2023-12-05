# Collectible items exploration hunt.gd

## Overview

The `Collectible items exploration hunt.gd` script manages the random spawning and interaction of collectible items in the game. It selects a random collectible item from the available children nodes and enables player detection and collision for that item while disabling them for the others. Additionally, it handles stopping item spawning when the player collects items.

**Purpose**: This script controls the random spawning and interaction of collectible items in the game.

## Properties

### `detectItem`

- Type: `CollisionShape2D`
- Description: A reference to the CollisionShape2D node attached to the currently active collectible item, used for player detection.

### `colItem`

- Type: `CollisionPolygon2D`
- Description: A reference to the CollisionPolygon2D node attached to the currently active collectible item, used for collision detection.

### `currItem`

- Type: `Node2D`
- Description: A reference to the currently active collectible item.

### `num_children`

- Type: Integer
- Description: The number of child nodes under the parent node where collectible items are stored.

### `rng`

- Type: `RandomNumberGenerator`
- Description: A RandomNumberGenerator used to generate random indices for selecting collectible items.

### `curr_rn`

- Type: Integer
- Description: The current random index for selecting collectible items.

### `timer`

- Type: Timer
- Description: A reference to the timer used for random item spawning.

### `curr_item_idx`

- Type: Integer
- Description: The index of the currently active collectible item.

### `inventory`

- Type: Node2D
- Description: Retrieves the game-wide inventory system that stores data across all scenes in the game, such as items collected, interactions unlocked, status of the current boss battle, player position, and more.

## Methods

### `_ready()`

```gdscript
func _ready():
	curr_item_idx = int(rng.randf_range(0, num_children-1))
	
	for child_idx in range(num_children):
		if child_idx != curr_item_idx:
			currItem = get_child(child_idx)
			currItem.hide()
			detectItem = currItem.get_child(0).get_node("PlayerDetectionItem").get_child(0)
			detectItem.set_deferred("disabled", true)
			colItem = currItem.get_child(0).get_node("CollisionPolygon2D")
			colItem.set_deferred("disabled", true)
```
When the scene loads, this script is called once. It selects a random collectible item from the available children nodes, hides the others, and disables player detection and collision for the non-selected items.

### `_on_random_spawning_collectible_item_timeout()`

```func _on_random_spawning_collectible_item_timeout():
	curr_rn = int(rng.randf_range(0, num_children))
	if curr_rn == curr_item_idx: curr_rn += 1
	
	currItem = get_child(curr_rn)
	currItem.show()
	detectItem = currItem.get_child(0).get_node("PlayerDetectionItem").get_child(0)
	detectItem.set_deferred("disabled", false)
	colItem = currItem.get_child(0).get_node("CollisionPolygon2D")
	colItem.set_deferred("disabled", false)
	
	currItem = get_child(curr_item_idx)
	currItem.hide()
	detectItem = currItem.get_child(0).get_node("PlayerDetectionItem").get_child(0)
	detectItem.set_deferred("disabled", true)
	colItem = currItem.get_child(0).get_node("CollisionPolygon2D")
	colItem.set_deferred("disabled", true)
	
	curr_item_idx = curr_rn
```
This method is triggered when the timer for random item spawning times out. It selects a new random collectible item, enables player detection and collision for it, and disables these for the previously active item.

### `_process(delta)`

```func _process(delta):
	if inventory.get_level_items().size() > 0:
		timer.stop()
		currItem = get_child(curr_item_idx)
		currItem.hide()
		detectItem = currItem.get_child(0).get_node("PlayerDetectionItem").get_child(0)
		detectItem.set_deferred("disabled", true)
		colItem = currItem.get_child(0).get_node("CollisionPolygon2D")
		colItem.set_deferred("disabled", true)
```
This script is called every frame. If the player has collected items and the level_items list in the inventory is not empty, it stops the item spawning timer and hides the currently active item while disabling player detection and collision for it.