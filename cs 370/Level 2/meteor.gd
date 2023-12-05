extends Area2D

var direction = Vector2.RIGHT
var speed = 600
@onready var animation = $AnimatedSprite2D
@onready var global_var = get_node("/root/Global")

func _ready():
	animation.play("Attack1")

func _physics_process(delta):
	position+= direction * speed*delta




func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



func _on_body_entered(body):
	if body.name =="player":
		global_var.hits =global_var.hits + 1
		if global_var.hits>=6:
			var inventory = get_node("/root/Inventory")
			inventory.set_boss_battle_status(false)
			get_tree().change_scene_to_file("res://BossBattleLoseScene.tscn")
			
		
