extends Node

var hits := 0
var hits2 := 0
var flag := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func restart_hits():
	hits = 0
	hits2 = 0

func entered():
	flag = false;
