extends GridContainer

var ItemClass = preload("res://Inventory/Item in inventory.tscn")
var item = null
signal itemCurrent(item_id)
var child : Panel
var used_slot_idx = 0
var items_ordered = []

@onready var inventory = get_node("/root/Inventory")

@onready var textInfoDisplay = get_parent().get_node("Item description")
signal itemAnimPlay(item_id)

signal panelClicked(panelIndex)
@onready var num_panels = get_child_count()

func _ready():
	var inventory_contents = inventory.get_inventory()
	# Get and iterate through all child nodes
	# for child in get_children():
	print("InventorySlot")
	print("inventory_conents: ", inventory_contents)
	for key in inventory_contents.keys():
		items_ordered.append(key)
		
		child = get_child(used_slot_idx)
		print("--- key: ", key)
		item = ItemClass.instantiate()
		itemCurrent.emit(key)
		child.add_child(item)
		
		used_slot_idx += 1
	
	print("Items ordered: ", items_ordered)
	print("Connecting signals...")
	print("Num panels: ", num_panels)
	for idx in range(num_panels):
		child = get_child(idx)
		print("   idx: ", idx, ", child: ", child)
		child.panelClicked.connect(_on_panel_clicked)


func _on_panel_clicked(panelIdx):
	print("on panel clicked signal recieved, panelIdx: ", panelIdx)
	if used_slot_idx >= panelIdx:
		print("  Slot ", panelIdx, " one clicked!")
		var curr_item = items_ordered[panelIdx - 1]
		print("  curr_item: ", curr_item)
		textInfoDisplay.text = "" + curr_item + ": " + str(inventory.get_item_count(curr_item))
		itemAnimPlay.emit(curr_item)
		child = get_child(panelIdx - 1)
		child.self_modulate = Color(0.6, 0.0, 0.5)
		child.z_index = 0
