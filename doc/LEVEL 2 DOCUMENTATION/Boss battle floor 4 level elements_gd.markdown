# Boss battle floor 4 level elements.gd

## Overview

The `Boss battle floor 4 level elements` handles nodes in level 2 boss battle room after the user wins the boss battle. In particular, the script uses the game wide inventory to check that the player has collected the "Coffee" item. If they have, the collision shape blocking the exit door to return to the exploration portion is disabled, allowing the player to exit. 

## Properties 

### `inventory`

- Type: `Node2D`
- Description: Retrieves the game wide inventory scripting that stores data across all scenes in the game, such as items collected, interactions unlocked, status of current boss battle, player position, and more.

## Methods
## `_ready()`
```gdscript
func _process(delta):
	if inventory.has_item("Coffee"):
		var blocking_collision = get_parent().get_node("Collision shapes").get_node("Wall and furniture collisions").get_node("Blocking door until item collected")
		blocking_collision.set_deferred("disabled", true)
```
The biult-in GoDot function _process() is called once per frame when the game is running. Thus, every frame we check if the inventory's items collected dictionary (which stores all collected items across the game) has been updated to contain the "Coffee" item. This will be the case when the player collects the "Coffee" after winning the boss battle. If so, the collision shape blocking the exit doorway is disabled, allowing the player to be able to exit through the door and return to the exploration scene for level 2.