extends Node2D

@onready var global_var = get_node("/root/Global")
@onready var curr_health = 6
@onready var Healthbar = $HealthBar
@onready var timmy = $AudioStreamPlayer2D
@onready var deathTimer = $deathTimer
@onready var inventory = get_node("/root/Inventory")
var healtharr = [3, 2.5, 2, 1.5, 1, 0.5, 0]

func _ready():
		global_var.restart_hits()
		
func _process(_delta):
	timmy.get_time()
	var t = timmy.time	
	Healthbar.play(str(healtharr[global_var.hits]))


func _on_death_timer_timeout():
	$bossBattle2.queue_free()
	
	
	var walls = get_node("walls")
	var leftwall = walls.get_node("leftWall")
	var rightwall = walls.get_node("rightWall")
	var bottom = walls.get_node("bottom")
	
	leftwall.set_deferred("disabled", true)
	rightwall.set_deferred("disabled", true)
	bottom.set_deferred("disabled", true)
