extends Node2D
class_name FiniteStateMachineGroundAttack

var current_state: SantisBossesState
var previous_state: SantisBossesState


func _ready():
	current_state = get_child(0) as SantisBossesState 
	previous_state = current_state
	current_state.enter()


func change_state(state): # lets you change the state
	current_state = find_child(state) as SantisBossesState
	current_state.enter()
	previous_state.exit()
	previous_state = current_state
	
func get_StateInString():# TODO erro here 
	return current_state.name
