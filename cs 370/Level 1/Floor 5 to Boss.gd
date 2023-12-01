extends CharacterBody2D

@onready var inventory = get_node("/root/Inventory")
@onready var player = get_parent().get_node("Player")
@onready var bossStatus = []


func _ready():
	bossStatus = inventory.get_boss_battle_status()
	var detect = get_node("PlayerDetection").get_child(0)
	if bossStatus:
		detect.set_deferred("disabled", true)

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		inventory.update_player_position(Vector2(2412.31, 966.9786))
		get_tree().change_scene_to_file("res://Level 1/bossbattle_floor5.tscn")
