extends Node2D


@onready var player = get_parent().get_parent().find_child("player")
@export var flasky_node = load("res://bossbattle2/flasky.tscn")
@onready var tim = $Timer
@onready var shoot_stat = true

func _process(_delta):
	if(tim.is_stopped()):
		tim.start()
	
func _on_timer_timeout():
	if(shoot_stat == true):
		shoot()
	
func shoot():
	var flasky = flasky_node.instantiate()
	flasky.visibility_layer = 3
	get_parent().get_node("AnimatedSprite2D").play("shoot")
	flasky.position = global_position + Vector2(60,-25)
	flasky.direction = (player.position - flasky.position).normalized()
	
	get_tree().current_scene.call_deferred("add_child", flasky)
