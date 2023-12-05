extends Node2D

@onready var timmy = $AudioStreamPlayer2D
@onready var deathTimer = $deathTimer
@onready var state = $boss/FiniteStateMachine/Shoot
@onready var global_hit = get_node("/root/Global")
var lanesize = 105

@onready var newPos1 = $boss.position
@onready var newPos2 = Vector2(lanesize, 0) + $boss.position
@onready var newPos3 = Vector2(lanesize*2, 0) + $boss.position

@onready var poses = [newPos1, newPos2, newPos3]
@onready var lasttime = 0.0
@onready var prev = 7
@onready var prevprev = 6

# Get inventory
@onready var inventory = get_node("/root/Inventory")
signal itemDisabled(itemIdx)
# Item to be collected to open the door once the boss is beaten
@onready var collectibleItem = get_node("Locked interactable objects").get_node("Collectible item key 0")

# Called when the node enters the scene tree for the first time.
func _ready():
	global_hit.restart_hits()
	collectibleItem.hide()


# when music is up, change scene (temp: main menu)
func _on_timer_timeout():
	state.exit()
	$boss.visible = false
	
	var blocking_collision = get_node("Lane collision").get_node("Blocking 1")
	blocking_collision.set_deferred("disabled", true)

	collectibleItem.show()
	inventory.set_boss_battle_status(true)
	$HealthBar.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$AudioStreamPlayer2D.get_time()
	var t = timmy.time
	
	if(global_hit.hits == 1):
		$HealthBar.play("2")
	elif(global_hit.hits == 2):
		$HealthBar.play("1")
	elif(global_hit.hits == 3):
		$HealthBar.play("0")
		state.exit()
		if(deathTimer.is_stopped()):
			deathTimer.start()
		#get_tree().change_scene_to_file("res://Level 1/floor5.tscn")	
	if(global_hit.hits < 3):
		if(t - lasttime >= 0.375):
			var randInd = randi_range(0, 2)
			if(prevprev == randInd && prev == randInd):
				randInd = randi_range(0, 2)
			prevprev = prev
			prev = randInd

			var randomElement = poses[randInd]

			$boss.set_position(randomElement)
			lasttime = t


func _on_death_timer_timeout():
	inventory.set_boss_battle_status(false)
	get_tree().change_scene_to_file("res://BossBattleLoseScene.tscn")
