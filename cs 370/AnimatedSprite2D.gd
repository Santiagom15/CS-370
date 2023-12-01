extends AnimatedSprite2D

var speed = 200  # Adjust this to control the sword's speed
#var lane_positions = []  # An array of Vector2 positions for the lanes
#var current_lane = -1  # -1 means not in any lane

func play_animation():
	play("sword")
func _ready():
	# Randomly select a lane (0 for left, 1 for center, 2 for right)
	speed = 200
	#position = lane_positions[current_lane]
	#play("sword")  # Replace with the name of your animation
func _process(delta):
	position.y += speed * delta
	play("sword")
