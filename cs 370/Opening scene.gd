extends Node2D

func _ready():
	var animLogo = get_node("Background graphics").get_node("Arrythmia logo animation")
	animLogo.play("Idle")
	animLogo.set_frame(0)

# When the "Exit" button pressed, quit the game
func _on_exit_button_down():
	get_tree().quit()

# When the "Start" button pressed, change the scene to the menu navigiation page
func _on_start_button_down():
	get_tree().change_scene_to_file("res://first_game.tscn")
