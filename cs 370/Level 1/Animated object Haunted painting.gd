extends CharacterBody2D
# Animate the haunted doll painting in level 1 setting

# Get the node with the fox animations for the animation sprite
@onready var anim = get_node("AnimatedSprite2D")

# Play the animation when the scene loads 
# (should repeat based on animation setting in AnimatedSprite2D node)
func _ready():
	anim.play("Haunted painting")
