extends Node2D

@onready var timmy = $AudioStreamPlayer2D
@onready var deathTimer = $deathTimer
@onready var state = $boss/FiniteStateMachine/Shoot
@onready var global_hit = get_node("/root/Global")
var lanesize = 105

#spawn positions of the boss in the lanes
@onready var newPos1 = $boss.position
@onready var newPos2 = Vector2(lanesize, 0) + $boss.position
@onready var newPos3 = Vector2(lanesize*2, 0) + $boss.position

#array of positions
@onready var poses = [newPos1, newPos2, newPos3]

@onready var lasttime = 0.0
@onready var prev = 7		#keeps track of last lane
@onready var prevprev = 6	#keeps track of last last lane

# Get inventory
@onready var inventory = get_node("/root/Inventory")
signal itemDisabled(itemIdx)
# Item to be collected to open the door once the boss is beaten
@onready var collectibleItem = get_node("Locked interactable objects").get_node("Collectible item key 0")

# Called when the node enters the scene tree for the first time.
func _ready():
	global_hit.restart_hits()	#restart hits at beginning of battle
	collectibleItem.hide()


# when music is up, stop attacks and show key
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
	#get time position of song in seconds
	$AudioStreamPlayer2D.get_time()
	var t = timmy.time
	
	#modulate healthbar animations depending on # of hits
	if(global_hit.hits == 1):
		$HealthBar.play("2")
	elif(global_hit.hits == 2):
		$HealthBar.play("1")
	elif(global_hit.hits == 3):
		$HealthBar.play("0")
		state.exit()
		if(deathTimer.is_stopped()):
			deathTimer.start()

	#if still alive, set boss position to random lane
	if(global_hit.hits < 3):
		if(t - lasttime >= 0.375):
			var randInd = randi_range(0, 2)
			if(prevprev == randInd && prev == randInd):	#ensure boss doesn't spawn > twice in the same lane in a row
				randInd = randi_range(0, 2)
			prevprev = prev
			prev = randInd

			var randomElement = poses[randInd]

			$boss.set_position(randomElement)
			lasttime = t


#switch to lose scene when player dies
func _on_death_timer_timeout():
	inventory.set_boss_battle_status(false)
	get_tree().change_scene_to_file("res://BossBattleLoseScene.tscn")
