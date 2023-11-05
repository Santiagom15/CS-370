extends GridContainer

var ItemClass = preload("res://Inventory/Item in inventory.tscn")
var item = null
var slot : Panel
var used_slot_idx = 0
var items_ordered = []

@onready var inventory = get_node("/root/Inventory")

@onready var textInfoDisplay = get_parent().get_node("Item description")

signal panelClicked(panelIndex)
var curr_item : String
var orig_color = null
var prev_panel_idx = null

func _ready():
	var inventory_contents = inventory.get_inventory()
	# Get and iterate through all child nodes
	# for child in get_children():
	for key in inventory_contents.keys():
		items_ordered.append(key)
		
		slot = get_child(used_slot_idx)
		slot.visible = true
		item = ItemClass.instantiate()
		slot.add_child(item)
		item._on_item_current(key)
		
		used_slot_idx += 1
	
	for idx in range(get_child_count(false)):
		slot = get_child(idx)
		slot.panelClicked.connect(_on_panel_clicked)
		
	if used_slot_idx > 0: orig_color = slot.modulate
			


func _on_panel_clicked(panelIdx):
	if used_slot_idx >= panelIdx:
		
		if prev_panel_idx != null:
			curr_item = items_ordered[prev_panel_idx - 1]
			slot = get_child(prev_panel_idx - 1)
			item = slot.get_child(0)
			item._on_item_anim_stop(curr_item)
			slot.self_modulate = orig_color
			slot.z_index = 0
		
		curr_item = items_ordered[panelIdx - 1]
		textInfoDisplay.text = "" + curr_item + ": " + str(inventory.get_item_count(curr_item))
		slot = get_child(panelIdx - 1)
		item = slot.get_child(0)
		item._on_item_anim_play(curr_item)
		slot.self_modulate = Color(0.0, 0.0, 0.0)
		slot.z_index = 0
		
		prev_panel_idx = panelIdx
