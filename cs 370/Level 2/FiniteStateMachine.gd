extends Node2D
class_name FiniteStateMachin

var current_state: SantisBossesState
var previous_state: SantisBossesState


func _ready():
	print(get_child(0).to_string())
	current_state = get_child(0) as SantisBossesState 
	previous_state = current_state
	current_state.enter()


func change_state(state): # lets you change the state
	current_state = find_child(state) as SantisBossesState
	current_state.enter()

	previous_state.exit()
	previous_state = current_state
