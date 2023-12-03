# Script for the story introduction page to play the logo animation and change the scene to menu page 
extends Node2D

func _ready():
	# Play the idle animation for the game logo
	var logoAnim = get_node("Arrythmia logo animation")
	logoAnim.play("Idle")

# Change the scene to the menu/page-navigation scene when the player presses "Continue" 
func _on_continue_button_button_down():
	get_tree().change_scene_to_file("res://first_game.tscn")
