extends Node2D

@onready var global_var = get_node("/root/Global")
@onready var curr_health = 6
@onready var Healthbar = $HealthBar
@onready var timmy = $AudioStreamPlayer2D
var healtharr = [3, 2.5, 2, 1.5, 1, 0.5, 0]

# Get inventory
@onready var inventory = get_node("/root/Inventory")
signal itemDisabled(itemIdx)
# Item to be collected to open the door once the boss is beaten
@onready var collectibleItem = get_node("Locked interactable objects").get_node("Collectible item coffee 0")

func _ready():
		global_var.restart_hits()
		collectibleItem.hide()
		
func _process(_delta):
	Healthbar.play(str(healtharr[global_var.hits]))

func _on_deathtimer_timeout():
	$BossbattleSanti2.queue_free()
	
	var battleCols = get_node("Collision shapes").get_node("Battle collisions")
	for child_idx in range(battleCols.get_child_count()):
		var childCol = battleCols.get_child(child_idx)
		childCol.set_deferred("disabled", true)
	collectibleItem.show()
	inventory.set_boss_battle_status(true)
	Healthbar.visible = false
