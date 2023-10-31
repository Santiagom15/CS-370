extends GridContainer

var ItemClass = preload("res://Inventory/Item in inventory.tscn")
var item = null
signal itemCurrent(item_id)
var child : Panel

@onready var inventory = get_node("/root/Inventory")

@onready var textInfoDisplay = get_parent().get_node("Item description")
signal itemAnimPlay(item_id)

func _ready():
	var inventory_contents = inventory.get_inventory()
	# Get and iterate through all child nodes
	# for child in get_children():
	var i = 0
	for key in inventory_contents.keys():
		var value = inventory_contents[key]

		child = get_child(i)
		
		item = ItemClass.instantiate()
		itemCurrent.emit(key)
		child.add_child(item)
		
		i += 1
		


func _on_slot_1_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT:
			# Left mouse button is clicked on the panel
			# Perform your actions here
			print("Slot one clicked!")
			textInfoDisplay.text = "Key: "
			itemAnimPlay.emit("Key")
