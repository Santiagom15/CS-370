# Floor1 to Boss.gd

## Overview

The `Floor1 to Boss.gd` script handles triggering a boss battle (changing the scene from the exploration level 4 portion to the level 4 boss battle room) when the player character enters the detection area just beyond the entrance door to the boss battle. The script interacts with the global `Inventory` system to check the boss battle status and manage the player's position.

## Properties

### `inventory`

- Type: `Node2D`
- Description: Retrieves the game wide inventory scripting that stores data across all scenes in the game, such as items collected, interactions unlocked, status of current boss battle, player position, and more.

### `player`

- Type: CharacterBody2D
- Description: A reference to the scene's player node.

### `bossStatus`

- Type: Boolean
- Description: A logical flag which is true when the player has won the level 2 boss battle and false when the player has lost.

### `speechBubble`

- Type: TextureRect
- Description: Node storing the image/texture of a text bubble. Used to help display text.

### `SpeechText`

- Type: RichTextLabel
- Description: Node with text describing that the player is now entering the boss battle room. Gives brief instructions about the battle and prompts the user to press spacebar to enter battle.

### `blockPlayerCol`

- Type: Collisionape2D
- Description: Collision shape blocking the player from entering the doorway to the boss battle room until they've pressed the space bar while the "SpeechText" node is displayed.

### `inDetectArea`

- Type: Boolean
- Description: Logical flag which is true when the player is currently in the associated player detection space and false otherwise. 

## Methods

### `_ready()`

```gdscript
func _ready():
	bossStatus = inventory.get_boss_battle_status()
	var detect = get_node("PlayerDetection").get_child(0)
	if bossStatus:
		detect.set_deferred("disabled", true)
		blockPlayerCol.set_deferred("disabled", true)
	
	speechBubble.z_index = 2
	speechText.z_index = 2
	speechBubble.hide()
	speechText.hide()
```
When the scene loads, this script is called once and it checks the inventory to see if the player has won the current boss battle, and if they have then the detection and collision shapes associated with entering the boss battle room are disabled. This prevents the player from replaying the boss battle after winning. This script also increases the z_index of the speech nodes (higher z_index values render/display nodes above others) and hides these nodes.

### `_process(delta)`

```func _process(delta):
	if inDetectArea && Input.is_action_just_released("ui_accept"):
		inventory.update_player_position(Vector2(2182, 515))
		get_tree().change_scene_to_file("res://Level 5/bossRoom_Floor1.tscn")
```
This script is called ever frame. It checks if the player is currently in the detection area and has pressed the space bar, and if so then the scene is changed to the level 4 boss battle room. Also, the player's position data is updated in the backend inventory so that when the player returns from the boss battle, they are respawned in the correct place.

### `_on_player_detection_body_entered(body)`

```func _on_player_detection_body_entered(body):
	if body.name == "Player":
		inDetectArea = true
		speechBubble.show()
		speechText.show()
```
When the player enters the detection space, the flag tracking if the player is in the detection space is set to true and the speech nodes are set to visible. 

### `_on_player_detection_body_exited(body)`

```func _on_player_detection_body_exited(body):
	if body.name == "Player":
		inDetectArea = false
		speechBubble.hide()
		speechText.hide()
```
When the player exits the detection space, the flag tracking if the player is in the detection space is set to false and the speech nodes are set to not visible. 
