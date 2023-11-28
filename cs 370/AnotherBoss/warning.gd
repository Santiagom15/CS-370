extends SantisBossesState
class_name warning

@onready var uiTime = false
@onready var animationPlayer = $AnimatedSprite2D

func transition():# amethod from the parent class that we can use to transition to new states
	if uiTime:
		get_parent().change_state("damage")
		animationPlayer.queue_free()

func exit():
	animationPlayer.stop()
	super.exit()
	
func _ready():
	animationPlayer.play("warning")

func _on_uitime_timeout():
	uiTime = true
