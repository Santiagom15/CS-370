extends AnimatedSprite2D
# Animate all idle animation objects in level navigation page

# Play the "Idle" animation when the scene loads 
func _ready():
	self.set_frame(0)
	self.play("Idle")
