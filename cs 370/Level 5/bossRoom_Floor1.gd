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
	
	Healthbar.hide()
	var fenceTilemap = get_node("End game").get_node("Fencing")
	fenceTilemap.hide()
	var fenceCollisions = get_node("End game").get_node("Fencing collision shapes")
	for child_idx in range(fenceCollisions.get_child_count()):
		var currCol = fenceCollisions.get_child(child_idx)
		currCol.set_deferred("disabled", true)
	var arrowGraphic = get_node("End game").get_node("Arrow")
	arrowGraphic.show()
