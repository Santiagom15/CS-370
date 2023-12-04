extends Node2D
class_name State1

#Abstract class
@onready var ray_cast = owner.find_child("RayCast2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	
func enter():
	set_physics_process(true)

func exit():
	set_physics_process(false)
	
func transition():
	pass
	
func _physics_process(_delta):
	transition()
