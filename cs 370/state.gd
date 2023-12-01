extends  Node2D
class_name SantisBossesState
# This one is mine
@onready var player = owner.get_parent().find_child("player")
@onready var ray_cast = owner.find_child("RayCast2D")
@onready var debug = owner.find_child("debug")
@onready var animator = owner.find_child("Animations")

func _ready():
	set_physics_process(false)
	
func enter():
	set_physics_process(true)

func exit():
	set_physics_process(false)

func transition():
	pass

func animation():
	pass
	
func _physics_process(_delta):
	transition()
	animation()
	debug.text = name
	
	
