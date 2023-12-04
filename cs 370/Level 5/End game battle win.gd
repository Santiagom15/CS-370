# Script for handling the elements that appear when the player defeats the last boss battle
# Indicating that the player has won the game
extends Node2D

@onready var arrowGraphic = get_node("Arrow")
@onready var fenceTilemap = get_node("Fencing")

@onready var speechGraphic = get_node("End display").get_node("Speech bubble")
@onready var endText = get_node("End display").get_node("End text")
@onready var menuText = get_node("End display").get_node("Return to menu text")
@onready var levelButton = get_node("End display").get_node("Level menu")

@onready var player = get_parent().get_node("player")

func _ready():
	arrowGraphic.hide()
	fenceTilemap.show()
	speechGraphic.hide()
	endText.hide()
	menuText.hide()
	levelButton.hide()

func _on_player_detection_body_entered(body):
	if body.name == "player":
		player.hide()
		arrowGraphic.hide()
		fenceTilemap.show()
		speechGraphic.show()
		endText.show()
		menuText.show()
		levelButton.show()

func _on_level_menu_button_down():
	get_tree().change_scene_to_file("res://Level Navigation/level_select.tscn")
