extends CharacterBody2D
# Animate the second vertical fridge with door swinging/opening to the right in level 1 setting

# Get the node with the fox animations for the animation sprite
@onready var anim = get_node("AnimatedSprite2D")

# Play the animation when the scene loads 
func _ready():
	anim.play("Fridge vertical 1")
