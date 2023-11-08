extends Area2D

var collisionShape : CollisionShape2D

func _ready():
	collisionShape = $CollisionShape2D  # Reference to the CollisionShape2D node

func _on_player_detection_body_entered(body):
	if body.name == "Player":  # Check if the colliding body is the player
		collisionShape.disabled = true  # Disable the CollisionShape2D

func _on_player_detection_body_exited(body):
	if body.name == "Player":  # Check if the colliding body is the player
		collisionShape.disabled = false  # Enable the CollisionShape2D

