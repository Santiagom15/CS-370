extends CharacterBody2D
# Animate all idle animation objects in level 1 setting

# Get the child AnimatedSprite2D node which is a child of the CharacterBody2D
# attached to this script
@onready var anim = get_node("AnimatedSprite2D")

# Play the "Idle" animation when the scene loads 
func _ready():
	anim.set_frame(0)
	anim.play("Idle")
