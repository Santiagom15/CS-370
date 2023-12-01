extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready():
	# Play the animation
	pass
	
func play_animation():
	animation_player.play("scalpelMove")

func _process(delta):
	animation_player.play("scalpelMove")
