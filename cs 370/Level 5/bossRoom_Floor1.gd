extends Node2D

@onready var globar_var = get_node("/root/Global")
# Called when the node enters the scene tree for the first time.
func _ready():
		globar_var.restart_hits()
