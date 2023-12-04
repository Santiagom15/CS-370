extends Node2D


@onready var spikeTimer = $Timer
@onready var timmy = $AudioStreamPlayer2D
@export var spike_node = load("res://bossbattle2/spike.tscn")
@onready var health = get_node("HealthBar")
@onready var global_var = get_node("/root/Global")
@onready var curr_health = 6
var healtharr = [3, 2.5, 2, 1.5, 1, 0.5, 0]# Called when the node enters the scene tree for the first time.

# Get inventory
@onready var inventory = get_node("/root/Inventory")
signal itemDisabled(itemIdx)
# Item to be collected to open the door once the boss is beaten
@onready var collectibleItem = get_node("Locked interactable objects").get_node("Collectible item key 0")

# Called when the node enters the scene tree for the first time.
func _ready():
	global_var.restart_hits()
	collectibleItem.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$AudioStreamPlayer2D.get_time()
	var t = timmy.time
	
	if(!spikeTimer.is_stopped()):
		if(int(t) % 5 == 0):
			spiked()
		if((int(t) % 5) == 4):
			$warningAlmostSpike.visible = true
		if((int(t) % 5) == 2):
			$warningDots.visible = true

	
	$HealthBar.play(str(healtharr[global_var.hits2]))


func _on_timer_timeout():
	inventory.set_boss_battle_status(true)

	$nurse_boss.visible = false
	$nurse_boss/Shoot.shoot_stat = false

	collectibleItem.show()
	inventory.set_boss_battle_status(true)
	health.hide()
	
	

func spiked():
	var spikey = spike_node.instantiate()
	get_tree().current_scene.call_deferred("add_child", spikey)
	$warningDots.visible = false
	$warningAlmostSpike.visible = false
