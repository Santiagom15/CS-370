extends CharacterBody2D


@export var speed = 300
@onready var _animated_sprite = $AnimatedSprite2D

func get_input():
	var input_direction = Input.get_vector ("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()

func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.play("walk_right")
	elif Input.is_action_pressed("ui_left"):
		_animated_sprite.play("walk_left")
	elif Input.is_action_pressed("ui_up"):
		_animated_sprite.play("walk_backward")
	elif Input.is_action_pressed("ui_down"):
		_animated_sprite.play("walk_forward")
	else:
		_animated_sprite.stop()


func _on_button_button_down():
	get_tree().change_scene_to_file("res://first_game.tscn")


func _on_return_home_button_down():
	get_tree().change_scene_to_file("res://first_game.tscn")
