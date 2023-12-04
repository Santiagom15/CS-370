extends CharacterBody2D

@onready var inventory = get_node("/root/Inventory")
@onready var player = get_parent().get_node("Player")
@onready var bossStatus = []

@onready var speechBubble = get_node("Speech").get_node("Speech bubble")
@onready var speechText = get_node("Speech").get_node("Speech text")
@onready var blockPlayerCol = get_node("Block player")

@onready var inDetectArea = false

func _ready():
	bossStatus = inventory.get_boss_battle_status()
	var detect = get_node("PlayerDetection").get_child(0)
	if bossStatus:
		detect.set_deferred("disabled", true)
		blockPlayerCol.set_deferred("disabled", true)
	
	speechBubble.z_index = 2
	speechText.z_index = 2
	speechBubble.hide()
	speechText.hide()


func _process(delta):
	if inDetectArea && Input.is_action_just_released("ui_accept"):
		inventory.update_player_position(Vector2(259, 1672))
		get_tree().change_scene_to_file("res://Level 2/bossRoom_Floor 4.tscn")


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		inDetectArea = true
		speechBubble.show()
		speechText.show()


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		inDetectArea = false
		speechBubble.hide()
		speechText.hide()
