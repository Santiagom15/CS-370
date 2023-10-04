extends CharacterBody2D
# Animate the blood dripping from the grocery store butcher asset in level 1 setting

# Get the node with the fox animations for the animation sprite
@onready var anim = get_node("AnimatedSprite2D")

# Play the animation when the scene loads 
func _ready():
	anim.play("Blood")
