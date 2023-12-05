# NPC interaction gaurd.gd

## Overview

The `NPC interaction gaurd.gd` script handles the interaction between the player and a guard (frog character) in level 2. The player interactions with the guard by getting within range and pressing the space bar. The guard has four states, which are also related to the states of the other dialogue-based NPCs in level 2. State 0 the guard is open to interaction, state 1 the guard has interaction with the player and told them to retrieve coffee from the boss battle room, state 2 is when the player gives the guard its coffee and the guard moves, and state 3 is when the guard can not be interacted with anymore. Of note, when the guard state is transitioned to 1, this changes the states of all other NPCs from state 0 to state 1. The script manages speech interactions, animations, and the movement of the guard based on the player's actions and the frog's state.

## Properties

### `interaction_name`

- Type: String
- Description: The name of the interaction, in this case "Guard" and is used to pass data about the interaction back and forth between the scene and the backend inventory.

### `curr_state`

- Type: int
- Description: Tracks the current state of the guard, determining the interaction phase.

### `play_interaction`

- Type: bool
- Description: Boolean flag indicating whether the player is in range for interaction.

### `play_start`

- Type: bool
- Description: Boolean flag for playing the current animation again.

### `speech`, `speechBubble`, `speechText`, `speechItem`

- Type: Nodes
- Description: Nodes representing the speech elements, including the speech bubble, text, and item needed for the interaction. In this case, the item needed is the Coffee item.

### `frogAnim`, `frogCol`, `frogItem`, `frogSparkle`

- Type: Nodes
- Description: Nodes representing various elements of the frog (guard) character, including animation, collision shape, item needed, and sparkle animation.

### `text_progress`

- Type: int
- Description: Integer tracking which speech interaction has already played. Used when the NPC has more than one section of dialogue in an interaction,

### `detect`

- Type: Node
- Description: Detection collision shape for detecting the player.

### `inventory`

- Type: Node
- Description: A reference to the game-wide inventory, used to store data between scenes.

## Methods

### `_ready()`
This method is called when the scene loads and initializes properties for the gaurd interaction. It sets and visibility and layering of nodes and plays the correct animations for the frog. Of note, this function checks the inventory to get the state of the "Guard" interaction, and if the state is 3 then the "Guard" is disabled (it is no longer able to interact with the player).

### `_process(delta)`
This method handles logic for player interactions, animations, and speech for the interactions. When conditions are met for interaction (of note, when player is in range of the guard and has pressed the space bar), the state of the guard determines what interaction will play. When state is 0, the guard tells the player about the coffee it wants the player to retrieve and the state is change to 1. When the state is 1 the player has the same dialogue as state 0. Of note, when the guard state is transitioned to 1, this changes the states of all other NPCs from state 0 to state 1. When the guard's state is 2 (which happens when the player has the "Coffee" item in inventory), then the frog thanks the player for the coffee and moves out of the way of the door, allowing the player to walk to the next level.

### `_on_player_detection_body_entered(body)`
Set the flag tracking the player being inside of the detection area to true.

### `_on_player_detection_body_exited(body)`
Set the flag tracking the player being inside of the detection area to false. Hide all of the speech interaction nodes and reset the dialogue progress. 

### `_on_frog_frame_changed()`
This method is connected to the `frame_changed` signal of the frog animation and handles the frame changes during the "Hop" animation. When the frog hops, the position of the frog is moved up and to the left so that it will move out of the way of the player so the player can access the exit stairs.

### `_on_frog_frame_finished()`
This method is connected to the `animation_finished` signal of the frog animation and handles actions when the frog animation finishes. Disables all interactions and speech options since this is state 3 for the guard.

### `_on_sparkle_animation_finished()`
This method is connected to the `animation_finished` signal of the sparkle animation and handles whent he sparkle animation is done by hiding the animation node.