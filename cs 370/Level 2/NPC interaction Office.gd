extends Node2D

@onready var frog_parent = get_node("Frog")
var frog_child: AnimatedSprite2D

var num_frog_frames: int
@onready var rng = RandomNumberGenerator.new()
var rand_frame : int


func play_animation(animation_name):
	for idx in range(frog_parent.get_child_count()):
		frog_child = frog_parent.get_child(idx)
		frog_child.play(animation_name)
		if animation_name == "Idle":
			rand_frame = int(rng.randf_range(0, num_frog_frames))
			frog_child.set_frame(rand_frame)
		else:
			frog_child.set_frame(0)


func _ready():
	var frogFrames = frog_parent.get_child(0).get_sprite_frames()
	num_frog_frames = frogFrames.get_frame_count("Idle")
	
	play_animation("Idle")
	for idx in range(frog_parent.get_child_count()):
		frog_child = frog_parent.get_child(idx)
		if "Flipped" in frog_child.get_name():
			frog_child.set_flip_h(true)


func _on_player_detection_body_entered(body):
	for idx in range(frog_parent.get_child_count()):
		frog_child = frog_parent.get_child(idx)
		if !("Flipped" in frog_child.get_name()):
			frog_child.set_flip_h(true)
	
	if body.name == "Player":
		play_animation("Blink")


func _on_player_detection_body_exited(body):
	for idx in range(frog_parent.get_child_count()):
		frog_child = frog_parent.get_child(idx)
		if !("Flipped" in frog_child.get_name()):
			frog_child.set_flip_h(false)
	
	if body.name == "Player":
		play_animation("Idle")
