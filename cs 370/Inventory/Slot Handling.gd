# Emit a signal with the name of the current/source node
# Used to determine which panel node in inventory was clicked of all panels in gridContainer
extends Panel

signal panelClicked(panelIndex)
var panelName: String
var idx: int

func _on_slot_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT:
			panelName = get_name()
			panelName = panelName[-1]
			idx = int(panelName)
			panelClicked.emit(idx)
