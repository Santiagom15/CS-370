extends Camera2D

@onready var parent: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	self.parent = find_parent("Sofia") # Replace with function body.

func get_grand():
	return parent
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
