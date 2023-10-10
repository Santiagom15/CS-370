extends CharacterBody2D

var collDoor : CollisionShape2D
var collDetect : CollisionShape2D
var in_coll = false
@onready var anim = $AnimatedSprite2D

func _ready():
	collDoor = $CollDoor  # Reference to the CollisionShape2D node
	collDetect = $PlayerDetection/CollisionShape2D
	
func _process(delta):
	if in_coll == true && Input.is_action_pressed("ui_accept"):
		anim.play("Interact")
		collDoor.set_deferred("disabled", true)  # Disable the CollisionShape2D
		collDetect.set_deferred("disabled", true)
	if $CollDoor.disabled == false:
		print("entered collDoor is enabled")
	else:
		print("entered collDoor is disabled")
	if $PlayerDetection/CollisionShape2D.disabled == false:
		print("entered collDetect is enabled")
	else:
		print("entered collDetect is disabled")
	

func _on_player_detection_body_entered(body):
	if body.name == "Player":  # Check if the colliding body is the player
		in_coll = true

func _on_player_detection_body_exited(body):
	pass
