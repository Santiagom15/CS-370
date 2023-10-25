extends CharacterBody2D

@onready var anim = get_node("AnimatedSlideDoor")
@onready var root = get_parent()
@onready var player = root.get_node("Player")
@onready var initialPlayerZIndex = player.z_index

func _ready():
	print(anim)
	print(root)
	print(player)


func _on_PlayerDectectionLayering_body_entered(body):
	print("entered")
	print("    player.z_index: ", player.z_index, ",   anim.z_index: ", anim.z_index)
	if body.name == "Player" and player != null and anim != null:
		player.z_index = anim.z_index + 1
		print("    changed")
		print("       player.z_index: ", player.z_index, ",   anim.z_index: ", anim.z_index)

func _on_PlayerDectectionLayering_body_exited(body):
	print("exited")
	print("    player.z_index: ", player.z_index, ",   anim.z_index: ", anim.z_index)
	if body.name == "Player" and player != null and anim != null:
		player.z_index = initialPlayerZIndex
		print("    changed")
		print("       player.z_index: ", player.z_index, ",   anim.z_index: ", anim.z_index)


func _on_PlayerDetectionAnimation_body_entered(body):
	if body.name == "Player":
		anim.play("SlideOpen")


func _on_PlayerDetectionAnimation_body_exited(body):
	if body.name == "Player":
		anim.play("SlideClosed")


func _on_animated_slide_door_animation_finished(anim_name):
	if anim_name == "SlideClosed":
		# The "SlideClosed" animation has finished playing, perform your next action here
		doNextAction()
		
func doNextAction():
	# Your code for the next action goes here
	print("Animation finished, now performing the next action.")

