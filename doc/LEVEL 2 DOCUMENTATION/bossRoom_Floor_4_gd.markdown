# bossRoom_Floor 4.gd

## Overview
The `bossRoom_Floor 4` script extends the `Node2D` class in the Godot game engine. It is designed to handle the behavior of the player characterd during the level 2 boss battle, including health management and interactions with other nodes in the scene.

## Properties
### `global_var`

- Type: Node
- Description: A reference to the global node (`/root/Global`) used for managing global game state.

### `curr_health`

- Type: Integer
- Description: The current health of the player character. Initialized to `6`.

### `Healthbar`

- Type: NodePath
- Description: A reference to the HealthBar node in the scene.

### `timmy`

- Type: NodePath
- Description: A reference to the AudioStreamPlayer2D node named `timmy` in the scene.

### `healtharr`

- Type: Array
- Description: An array representing different health values corresponding to the player's hits. Used for managing the player's health progression.

### `inventory`

- Type: Node2D
- Description: Retrieves the game wide inventory scripting that stores data across all scenes in the game, such as items collected, interactions unlocked, status of current boss battle, player position, and more.

### `collectibleItem`

- Type: Node2D
- Description: Instance of the collectible item scene, in this case a Coffee item.

## Signals

### `itemDisabled(itemIdx)`

- Description: Signal declared here because it is declared and connected in the scripting for the exit door node, but the signal is not actually used in boss battles.
- Parameters:
  - `itemIdx` (int): Index of the disabled item.

## Methods

### `__on_deathtimer_timeout()`

```gdscript
func _on_deathtimer_timeout():
	$BossbattleSanti2.queue_free()
	
	var battleCols = get_node("Collision shapes").get_node("Battle collisions")
	for child_idx in range(battleCols.get_child_count()):
		var childCol = battleCols.get_child(child_idx)
		childCol.set_deferred("disabled", true)
	collectibleItem.show()
	inventory.set_boss_battle_status(true)
	Healthbar.visible = false
```
This method is called when the main timer for the came ends and it emits a signal which is attached to this script. The main timer's end is indicative of the player winning the boss battle. This method frees the data associated with the battle, it disables all collision nodes used to limit the motion of the player during the battle, makes the Coffee item visible, sets the boss battle win status for the current level to true, and disables visibility on the health bar.

## Usage
To use this script, attach it to the player character node in the Godot scene. Ensure that the necessary dependencies, such as the global node, HealthBar node, and AudioStreamPlayer2D node, are properly set up for the script to function correctly.