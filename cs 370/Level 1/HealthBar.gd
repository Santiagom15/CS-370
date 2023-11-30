extends AnimatedSprite2D
@onready var camara = get_parent()

# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
	print(camara.get_screen_center_position)
	position = camara.get_screen_center_position ( )- Vector2(400,200)
	#print(camara.postion,"Relative position ",global_position)

