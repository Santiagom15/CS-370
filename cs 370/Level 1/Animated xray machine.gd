extends CharacterBody2D
# Animate the XRAY machine with the TV screen and moving sensor arm in level 1 setting

# Get the node with the fox animations for the animation sprite
@onready var anim = get_node("AnimatedSprite2D")

# Play the animation when the scene loads 
func _ready():
	anim.play("Xray machine")
