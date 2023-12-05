# Item.gd

## Overview

The `Item.gd` script is responsible for managing individual items in the inventory page for display. Each item is associated with a specific animation that plays when the item is selected or interacted with. Signalling between the inventory page and the individual inventory items passes along information about the specific item to be displayed.


## Properties

### `anim`

- Type: AnimationPlayer
- Description: A reference to the AnimationPlayer node responsible for playing item animations.

## Signals

### `itemAnimLooped`

- Description: A signal emitted when the item's animation has looped.

## Methods

### `_ready()`

This method is called when the script instance is ready. It initializes the item by hiding the animation.

### `_on_item_current(item_id)`

This method is called when an item is set as the current item in the inventory. It displays the associated animation and sets it to the first frame.

### `_on_item_anim_play(item_id)`

This method is called to play the animation associated with the item.

### `_on_item_anim_stop(item_id)`

This method is called to pause the item's animation and reset it to the first frame when the animation should stop.

### `_on_item_animation_animation_looped()`

This method is triggered when the item's animation has looped. It emits the itemAnimLooped signal.