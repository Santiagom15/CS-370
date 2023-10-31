extends Panel

var ItemClass = preload("res://Inventory/Item in inventory.tscn")
var item = null

func _ready():
	item = ItemClass.instantiate()
	add_child(item)
