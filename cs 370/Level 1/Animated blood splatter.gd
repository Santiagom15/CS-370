extends CharacterBody2D
# Animate the blood splatter from the halloween room (non-spritesheet) asset in level 1 setting

# Get the node with the fox animations for the animation sprite
@onready var anim = get_node("AnimatedSprite2D")

# Play the animation when the scene loads 
func _ready():
	anim.play("Blood")
