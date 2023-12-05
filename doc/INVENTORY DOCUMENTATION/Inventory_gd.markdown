# Inventory.gd

## Overview

The `Inventory.gd` script serves as a GoDot singleton to hold and manage global data that is accessible from any scene or script in the entire game. It is responsible for storing and updating player inventory, current level information, player position, and various game-related data.

**Purpose**: This script maintains a global inventory system for collectible items and power-ups in the game, as well as other game-related data that needs to persist between scenes.

## Properties

### `inventory`

- Type: Dictionary
- Description: Stores the player's inventory items and their counts.

### `currLevel`

- Type: String
- Description: Stores the directory/path of the current level scene or the previous level if the player is in a non-level scene (e.g., home or inventory page).

### `playerPosition`

- Type: Vector2
- Description: Stores the current/previous position of the player in a level scene.

### `transport`

- Type: Boolean
- Description: A flag that indicates whether the player has left a level prematurely (e.g., by entering the inventory).

### `levelItems`

- Type: Array of Strings
- Description: An array that tracks specific items collected in the current scene.

### `levelUnlocks`

- Type: Array of Strings
- Description: An array that stores the item_id of unlocked interactible items in the current scene.

### `bossBattleWinStatus`

- Type: Boolean
- Description: A logical flag that indicates whether the player won the boss battle for the current level.

### `interactionStates`

- Type: Dictionary
- Description: Stores the state of all major collectible or NPC-based interactions in the current scene. It maps interaction names to integers representing their states.

### `prevPage`

- Type: String
- Description: Stores the path of the previous page scene, excluding instructions pages, start pages, or boss battle scenes.

### `highestLevelUnlocked`

- Type: int
- Description: Stores the number of the highest level unlocked/reached in the game.


**Note:**
This script contains many different functions for handling the above data structures to be stored and passed between all scenes in the game. In general, some of the above data structures only have a couple of related functions (such as setting a new value or retrieiving/returning the current value), but many of them have many associated functions, such as adding new items, clearing the structure, or returning the structure. 
Check out the Inventory.gd file for in-depth commentation on all methods.