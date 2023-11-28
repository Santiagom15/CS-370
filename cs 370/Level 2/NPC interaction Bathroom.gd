extends Node2D

@onready var frog_parent = get_node("Frog")
var frog_child: AnimatedSprite2D

#@onready var animLockFrames = animLock.get_sprite_frames()
#@onready var total_num_key_frames = animLockFrames.get_frame_count("Bolt")
@onready var rng = RandomNumberGenerator.new()
#rng.randf_range(0, camera_width)

func play_animation(animation_name):
	for idx in range(frog_parent.get_child_count()):
		frog_child = frog_parent.get_child(idx)
		frog_child.set_frame(0)
		frog_child.play(animation_name)

func _ready():
	play_animation("Idle")
	for idx in range(frog_parent.get_child_count()):
		frog_child = frog_parent.get_child(idx)
		if "Flipped" in frog_child.get_name():
			frog_child.set_flip_h(true)

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		play_animation("Blink")

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		play_animation("Idle")
