extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_battle_button_down():
	get_tree().change_scene_to_file("res://bossbattle2/bossbattle2.tscn")

func _on_restart_level_button_down():
	get_tree().change_scene_to_file("res://Level 2/Floor 4.tscn")
