extends Node2D

@onready var global_var = get_node("/root/Global")
@onready var curr_health = 6
@onready var Healthbar = $player/Camera2D2/HealthBar
@onready var timmy = $AudioStreamPlayer2D
var healtharr = [3, 2.5, 2, 1.5, 1, 0.5, 0]
func _ready():
		global_var.restart_hits()
		
func _process(_delta):
	timmy.get_time()
	var t = timmy.time
	
	
	
	Healthbar.play(str(healtharr[global_var.hits]))
