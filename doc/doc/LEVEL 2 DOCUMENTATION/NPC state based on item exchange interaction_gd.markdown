# NPC state based on iteam exchange interaction.gd

## Overview

The `NPC state based on iteam exchange interaction` script controls interactions between the player and the dialogue having frog NPCs (not the guard frog) for level 2 exploration portion. Track the state of the NPC interaction. Depending on the state, the player can interact with the NPC in different ways and the interacitons of the frog are dependent upon a simple state machine. When the state is 0, the player can talk to the NPC who will tell the player to talk to the guard (the state is changed to one after the player talks to the guard), for state 1 the frog will request an item in exchange for an item, for state 2 the frog will recieve the wanted item from the player and give up their item, and state 3 the player can no longer interact with the frogs.

## Properties

### `interaction_name`

- Type: String
- Description: A string containing the name of the NPC for identification.

### `curr_state`

- Type: int
- Description: An integer tracking the current state of the NPC interaction.
  - 0: Player cannot interact with the NPCs.
  - 1: Player can interact, initiating a dialogue.
  - 2: Player can perform an item exchange with the NPC.
  - 3: Player cannot interact.

### `play_interaction`

- Type: bool
- Description: A boolean flag indicating whether the player is in the range of the NPC for interaction.

### `text_progress`

- Type: int
- Description: An integer tracking the progress of dialogue interactions for the current state.

### `inventory`

- Type: Reference to `/root/Inventory`
- Description: A reference to the game-wide inventory used to store data between scenes.

### `speechBubble`, `speechText`, `speechItemWant`, `speechItemGive`

- Type: Nodes representing Speech elements
- Description: Nodes responsible for displaying speech bubble, text, and items during NPC interactions.

### `itemRetrieved`, `itemSparkle`

- Type: Nodes representing the item retrieved and sparkle animation
- Description: Nodes responsible for displaying the item collected by the player and a sparkle animation.

### `detectInteraction`, `detectItem`

- Type: Detection collision shapes
- Description: Collision shapes used to detect the player's proximity for initiating interactions and collecting items.

### `descriptions`, `descriptionPositions`

- Type: Dictionaries
- Description: Dictionaries holding dialogue options and positions for specific NPC interactions.

## Methods

### `_ready()`
Description: Method called when the node enters the scene tree for the first time.
Initializes various components and checks the current state of NPC interaction.
Sets up dialogue options and positions for specific NPCs.

### `_process(delta)`

Description: Method called on every game frame.
Manages player interactions, dialogues, and item exchanges based on the current state.
Updates the game inventory accordingly.

### `_on_player_detection_interaction_body_entered(body)`, `_on_player_detection_interaction_body_exited(body)`

Description: Methods connected to the `body_entered` and `body_exited` signals of the interaction detection area.
Update the `play_interaction` flag based on player proximity.

### `_on_sparkle_animation_animation_finished()`

Description: Method connected to the animation finished signal of the sparkle animation.
Hides the sparkle animation after it finishes playing.
