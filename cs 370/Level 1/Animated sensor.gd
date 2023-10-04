extends CharacterBody2D
# Animate tthe sensor associated with the medical machine in level 1 setting
# In the Modern Interiors asset pack, it's titled grocery store ticket machine

# Get the node with the fox animations for the animation sprite
@onready var anim = get_node("AnimatedSprite2D")

# Play the animation when the scene loads 
func _ready():
	anim.play("Sensor")
