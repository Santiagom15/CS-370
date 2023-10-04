extends CharacterBody2D
# Animate the second blue drawer/cabinet with food in it in level 1 setting

# Get the node with the fox animations for the animation sprite
@onready var anim = get_node("AnimatedSprite2D")

# Play the animation when the scene loads 
func _ready():
	anim.play("Blue cabinet 1")
