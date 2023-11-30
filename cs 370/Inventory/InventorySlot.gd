extends GridContainer

var ItemClass = preload("res://Inventory/Item in inventory.tscn")
var item = null
var slot : Panel
var used_slot_idx = 0
var items_ordered = []

@onready var inventory = get_node("/root/Inventory")

@onready var textInfoDisplay = get_parent().get_node("Item description")
@onready var textInventoryTitle = get_parent().get_node("Inventory title")

signal panelClicked(panelIndex)
var curr_item : String
var orig_color = null
var prev_panel_idx = null

signal itemAnimLooped
var curr_text = ""

var descriptions: Dictionary = {}


func _ready():
	
	# Define the list of descriptions for all possible collectible items in the game
	# The appropriate description will be shown when an item in inventory is pressed
	descriptions["Key"] = "Key unlocks locked doors"
	descriptions["Frog"] = "A cool companion"
	descriptions["Candle"] = "Help light the way"
	descriptions["BoltCutter"] = "Open bolted off doors"
	descriptions["Flower"] = "This looks pretty, I hear frogs really like blue flowers"
	descriptions["Hat"] = "Nice to wear, too bad it's too big for you"
	descriptions["Brain"] = "I think you have one already, need an extra?"
	descriptions["Money"] = "Use this to buy things, maybe from the vending machine?"
	descriptions["Coffee"] = "A nice pick me up, but sometimes if makes you more tired"
	
	var inventory_contents = inventory.get_inventory()
	
	if len(inventory_contents) == 0:
		textInfoDisplay.clear()
		textInfoDisplay.append_text("[center]Looking empty in here, try collecting something")
	
	else: 
		# Get and iterate through all child nodes
		# for child in get_children():
		for key in inventory_contents.keys():
			items_ordered.append(key)
			
			slot = get_child(used_slot_idx)
			slot.visible = true
			item = ItemClass.instantiate()
			slot.add_child(item)
			item._on_item_current(key)
			item.itemAnimLooped.connect(_item_anim_looped)
			
			used_slot_idx += 1
		
		for idx in range(get_child_count(false)):
			slot = get_child(idx)
			slot.panelClicked.connect(_on_panel_clicked)
			
		if used_slot_idx > 0: orig_color = slot.modulate


func _item_anim_looped():
	textInfoDisplay.clear()
	textInfoDisplay.append_text(curr_text)
	textInventoryTitle.clear()
	textInventoryTitle.append_text("[center]Inventory")


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
		#textInfoDisplay.text = "" + curr_item + ": " + str(inventory.get_item_count(curr_item))
		curr_text = "[center]" + curr_item + ": " + str(inventory.get_item_count(curr_item)) + "\n" + descriptions[curr_item] + "[/center]"
		textInfoDisplay.clear()
		textInfoDisplay.append_text("[shake rate=8.0]" + curr_text + "[/shake]")
		textInventoryTitle.clear()
		textInventoryTitle.append_text("[shake rate=12.0][center]Inventory")
		slot = get_child(panelIdx - 1)
		item = slot.get_child(0)
		item._on_item_anim_play(curr_item)
		slot.self_modulate = Color(0.0, 0.0, 0.0)
		slot.z_index = 0
		
		prev_panel_idx = panelIdx
