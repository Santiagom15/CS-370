extends Node2D

@export var meteorNode: PackedScene
@onready var timer = $MeteroShoot

func transition():
		pass
		



func _on_metero_shoot_timeout():
		shoot()
	


func shoot():
	var meteor = meteorNode.instantiate()
	# figure out the logic later 
