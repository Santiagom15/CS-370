extends Node2D

@onready var timmy = $AudioStreamPlayer2D
@onready var timer = $Timer

var lanesize = 105

@onready var newPos1 = $boss.position
@onready var newPos2 = Vector2(lanesize, 0) + $boss.position
@onready var newPos3 = Vector2(lanesize*2, 0) + $boss.position

@onready var poses = [newPos1, newPos2, newPos3]
@onready var lasttime = 0.0
@onready var prev = 7
@onready var prevprev = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.start()

	
# when music is up, change scene (temp: main menu)
func _on_timer_timeout():
	get_tree().change_scene_to_file("res://first_game.tscn")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$AudioStreamPlayer2D.get_time()
	var t = timmy.time
	print(t) 
	$HealthBar.play("3-2")
	if(t - lasttime >= 0.75):
		var randInd = randi_range(0, 2)
		if(prevprev == randInd && prev == randInd):
			randInd = randi_range(0, 2)
		prevprev = prev
		prev = randInd
		
		var randomElement = poses[randInd]
	
		$boss.set_position(randomElement)
		lasttime = t
		
	



