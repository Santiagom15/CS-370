extends  Node2D
class_name State


@onready var player = owner.get_parent().find_child("player")
@onready var ray_cast = owner.find_child("RayCast2D")
@onready var debug = owner.find_child("debug")

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
	debug.text = name
	
	
