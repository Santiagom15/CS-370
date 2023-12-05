extends Node2D

@onready var level_num = int(str(get_name())[-1])
@onready var col = get_node("ParentCol").get_node("Collision")
@onready var speech = get_node("Locked speech")
@onready var detect = get_node("PlayerDetection").get_node("CollisionShape2D")

@onready var inventory = get_node("/root/Inventory")

func _ready():
	speech.z_index = 2
	speech.hide()
	if inventory.get_level_number_unlocked() >= level_num:
		col.set_deferred("disabled", true)
		detect.set_deferred("disabled", true)

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		speech.show()

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		speech.hide()