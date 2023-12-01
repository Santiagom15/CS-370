extends Node2D


@onready var spikeTimer = $Timer
@onready var timmy = $AudioStreamPlayer2D
@export var spike_node = load("res://bossbattle2/spike.tscn")
#@onready var health = get_node("HealthBar")
@onready var global_var = get_node("/root/Global")
@onready var curr_health = 6
var healtharr = [3, 2.5, 2, 1.5, 1, 0.5, 0]# Called when the node enters the scene tree for the first time.


# Called when the node enters the scene tree for the first time.
func _ready():
	global_var.restart_hits()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$AudioStreamPlayer2D.get_time()
	var t = timmy.time
	
	if(int(t) % 5 == 0):
		spiked()
	if((int(t) % 5) == 4):
		$warningAlmostSpike.visible = true
	if((int(t) % 5) == 2):
		$warningDots.visible = true

	
	$HealthBar.play(str(healtharr[global_var.hits2]))


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://deathscene.tscn")

	

func spiked():
	var spikey = spike_node.instantiate()
	get_tree().current_scene.call_deferred("add_child", spikey)
	$warningDots.visible = false
	$warningAlmostSpike.visible = false
