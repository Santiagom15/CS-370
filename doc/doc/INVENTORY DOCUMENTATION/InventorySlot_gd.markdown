# InventorySlot.gd

## Overview

The `InventorySlot.gd` script is responsible for managing the game's inventory system in the inventory page display. It handles the placement and interaction of collected items in the inventory grid, displays item descriptions when an item is clicked, and animates item interactions based on which items the player has in their backend inventory.

**Purpose**: This script facilitates the management and display of collected items in the player's inventory.

## Properties

### `ItemClass`

- Type: Scene
- Description: A reference to the scene representing individual items in the inventory.

### `item`

- Type: Node
- Description: An instance of the `ItemClass` scene representing a specific item in the inventory grid.

### `slot`

- Type: Panel
- Description: A reference to a panel in the inventory grid where an item can be placed.

### `used_slot_idx`

- Type: int
- Description: An integer that keeps track of the number of slots used in the inventory grid.

### `items_ordered`

- Type: Array
- Description: An array that stores the names of collected items in the order they appear in the inventory grid.

### `inventory`

- Type: Node
- Description: A reference to the global inventory node located at "/root/Inventory." This node is used to manage collected items and their counts.

### `textInfoDisplay`

- Type: Label
- Description: A reference to a label node used to display item descriptions when an item is clicked.

### `textInventoryTitle`

- Type: Label
- Description: A reference to a label node used to display the title of the inventory.

### `curr_item`

- Type: String
- Description: A string representing the currently selected item's name.

### `orig_color`

- Type: Color
- Description: The original color of a panel slot. It's used to reset the slot's color after selecting an item.

### `prev_panel_idx`

- Type: int
- Description: An integer representing the previously selected panel index.

### `itemAnimLooped`

- Type: Signal
- Description: A signal emitted when an item's animation has looped.

### `curr_text`

- Type: String
- Description: A string representing the current item's description text.

### `descriptions`

- Type: Dictionary
- Description: A dictionary containing descriptions for all possible collectible items in the game.

## Methods

### `_ready()`

This method is called when the script instance is ready. It initializes the inventory grid, loads item descriptions, and sets up event connections.

### `_item_anim_looped()`

This method is called when an item's animation has looped. It updates the item description text and inventory title.

### `_on_panel_clicked(panelIdx)`

This method is triggered when a panel in the inventory grid is clicked. It updates the selected item's description, plays item animations, and manages panel colors.