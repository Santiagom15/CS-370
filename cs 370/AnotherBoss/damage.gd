extends SantisBossesState
class_name damage

@export var spawnAttack: PackedScene
# Called when the node enters the scene tree for the first time.
func enter():
	super.enter()
	spawn()

	
func spawn():
	var attack = spawnAttack.instantiate()
	attack.position = global_position
	get_tree().current_scene.call_deferred("add_child",attack)
