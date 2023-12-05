# Level data level2.gd

## Overview

The `Level data level2.gd` serves as a controller for managing game-wide data within the current scene/level such as inventory, player position, collectible items, and interactable objects.

## Properties

### `inventory`

- Type: `Node2D`
- Description: Retrieves the game wide inventory scripting that stores data across all scenes in the game, such as items collected, interactions unlocked, status of current boss battle, player position, and more.

### `player`

- Type: Node2D
- Description: A reference to the player node.

### `collectible_items`

- Type: Node2D
- Description: A reference to the parent node whose children are all of the collectible item nodes within the current scene.

### `interactable_objects`

- Type: Node2D
- Description: A reference to the parent node containing all locked interactable object nodes within the current scene.

## Signals

### `itemDisabled(itemIdx)`

- Description: Signal is emitted by this script and connected to the locked interaction objects scripting. This signal is emitted when the list of current unlocked interacitons in the inventory contains a locked object in this scene, so the signal is emitted to the object node and it is disabled.
- Parameters:
  - `itemIdx` (int): Index of the disabled item. Used to track which interaciton/object is which between the current scene and the inventory backend.

### `lockDisabled(lockIdx)`

- Description: Signal is emitted by this script and connected to the collectible items scripting. This signal is emitted when the list of current collected items in the inventory contains a collected item in this scene, so the signal is emitted to the item node and it is disabled.
- Parameters:
  - `lockIdx` (int): Index of the disabled lock.Used to track which item is which between the current scene and the inventory backend.

## Methods

### `_ready()`

```gdscript
func _ready():
	inventory.update_current_level("res://Level 2/Floor 4.tscn")
	
	if inventory.get_transport():
		player.global_position = inventory.get_player_position()
		
	for unlocked_item in inventory.get_level_items():
		itemDisabled.emit(unlocked_item)
		
	for unlocked_item in inventory.get_unlocks():
		lockDisabled.emit(unlocked_item)
	
	if inventory.get_level_number_unlocked() < 2:
		inventory.update_level_number_unlocked(2)
```
Function get_transport() in the inventory scripting returns a logical flag which is true when the player's position recorded in the inventory is different than the player's position when the scene is loaded. This happens when the player plays part of a exploration portion of a level, and then changes the scene (for example to the level navigiation or inventory page). When this is true, the player's position is set in the scene to the position stored in inventory.
Next, for all unlocked objects in the inventory backend, a signal is emitted (to be collected by the specific locked interaction nodes) to disable each of those objects within the scene. The same is done for the collectible items in the scene which have already been collected. This prevents the player from collecting/unlocking the same items/interactions more than once after changing the scene (to a scene that isn't another level).
Lastly, the highest level unlocked in the inventory is updated if level 2 is the current highest level the player has reached.

## `_process(delta)`

```func _process(delta):
	inventory.update_player_position(player.global_position)
```
Every frame, update the data in the inventory relating to the player's current position within the scene.