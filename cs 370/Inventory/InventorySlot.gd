extends GridContainer

var ItemClass = preload("res://Inventory/Item in inventory.tscn")
var item = null
signal itemCurrent(item_id)
var child : Panel

@onready var inventory = get_node("/root/Inventory")

func _ready():
	var inventory_contents = inventory.get_inventory()
	# Get and iterate through all child nodes
	# for child in get_children():
	var i = 0
	for key in inventory_contents.keys():
		var value = inventory_contents[key]
		print("Key:", key, "Value:", value)
		# You can access and work with each child node here
		child = get_child(i)
		print("Child node name:", child.get_name())
		
		item = ItemClass.instantiate()
		itemCurrent.emit(key)
		child.add_child(item)
		
		i += 1
		
