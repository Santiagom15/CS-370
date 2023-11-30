extends Node2D

var frog_parent : Node2D
var frog_child : AnimatedSprite2D

var frogRight = "Frog Right"
var frogLeft = "Frog Left"

var in_right = false
var in_left = false

var num_frog_frames: int
@onready var rng = RandomNumberGenerator.new()
var rand_frame : int


func set_flip(flip_bool, frogDirection):
	frog_parent = get_node(frogDirection)
	for idx in range(frog_parent.get_child_count()):
		frog_child = frog_parent.get_child(idx)
		frog_child.set_flip_h(flip_bool)


func play_animation(animation_name):
	frog_parent = get_node(frogRight)
	for idx in range(frog_parent.get_child_count()):
		frog_child = frog_parent.get_child(idx)
		frog_child.play(animation_name)
		if animation_name == "Idle":
			rand_frame = int(rng.randf_range(0, num_frog_frames))
			frog_child.set_frame(rand_frame)
		else:
			frog_child.set_frame(0)
	
	frog_parent = get_node(frogLeft)
	for idx in range(frog_parent.get_child_count()):
		frog_child = frog_parent.get_child(idx)
		frog_child.play(animation_name)
		if animation_name == "Idle":
			rand_frame = int(rng.randf_range(0, num_frog_frames))
			frog_child.set_frame(rand_frame)
		else:
			frog_child.set_frame(0)


func _ready():
	frog_parent = get_node(frogLeft)
	var frogFrames = frog_parent.get_child(0).get_sprite_frames()
	num_frog_frames = frogFrames.get_frame_count("Idle")
	
	set_flip(true, frogLeft)
	set_flip(false, frogRight)
	play_animation("Idle")


func _on_player_detection_left_body_entered(body):
	if body.name == "Player":
		in_left = true
		set_flip(false, frogLeft)
		set_flip(false, frogRight)
		play_animation("Blink")


func _on_player_detection_left_body_exited(body):
	if body.name == "Player":
		in_left = false
		if in_right == false:
			set_flip(true, frogLeft)
			set_flip(false, frogRight)
			play_animation("Idle")


func _on_player_detection_right_body_entered(body):
	if body.name == "Player":
		in_right = true
		set_flip(true, frogLeft)
		set_flip(true, frogRight)
		play_animation("Blink")


func _on_player_detection_right_body_exited(body):
	if body.name == "Player":
		in_right = false
		if in_left == false:
			set_flip(true, frogLeft)
			set_flip(false, frogRight)
			play_animation("Idle")
