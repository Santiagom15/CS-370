extends CanvasModulate

#create a gradient to then instantiate on base.gd 
var time:float = 0.0

func _process(delta: float) -> void:
	time += delta 
	var value = (sin(time - PI /2.0) +1.0) /2.0
