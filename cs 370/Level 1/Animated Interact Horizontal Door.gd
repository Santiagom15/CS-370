extends CharacterBody2D

@onready var anim = get_node("AnimatedDoor")

# Play the "Idle" animation when the scene loads 
func _ready():
	anim.play("Open")
