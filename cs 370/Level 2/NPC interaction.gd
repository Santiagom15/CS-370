extends Node2D


@onready var num_children = get_child_count()

var in_right = false
var in_left = false


func play_animation(animation_name):
	print("animation_name: ", animation_name)
	for idx in range(num_children):
		var child = get_child(idx)
		print("   child: ", str(child.get_name()))
		if "Frog" in str(child.get_name()):
			child.set_frame(0)
			child.play(animation_name)


func _ready():
	print("num_children: ", num_children)
	play_animation("Idle")


func _on_player_detection_left_body_entered(body):
	if body.name == "Player":
		in_left = true
		play_animation("Blink")


func _on_player_detection_left_body_exited(body):
	if body.name == "Player":
		in_left = false
		if in_right == false:
			play_animation("Idle")
		play_animation("Idle")


func _on_player_detection_right_body_entered(body):
	if body.name == "Player":
		in_right = true
		play_animation("BlinkFlipped")


func _on_player_detection_right_body_exited(body):
	if body.name == "Player":
		in_right = false
		if in_left == false:
			play_animation("IdleFlipped")
		play_animation("IdleFlipped")
