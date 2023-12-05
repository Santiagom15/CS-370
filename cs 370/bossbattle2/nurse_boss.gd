extends CharacterBody2D

@onready var player = get_parent().find_child("player")

var direction = Vector2.DOWN

#set direction of the nurse_boss
func _process(_delta):
	direction = (player.position - global_position).normalized()
