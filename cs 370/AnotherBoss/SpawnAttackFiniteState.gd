extends Node2D
class_name FiniteStateMachineGroundAttack

var current_state: SantisBossesState
var previous_state: SantisBossesState


func _ready():
	current_state = get_child(0) as SantisBossesState 
	previous_state = current_state
	current_state.enter()


func change_state(state): # lets you change the state
	previous_state = current_state
	current_state = find_child(state) as SantisBossesState
	previous_state.exit()
	current_state.enter()
	print("Current State: ",current_state," Previous State: ", previous_state)
	
	
func get_StateInString():# 
	return current_state.name
