extends Node

@export var starting_item_scenes: Array[PackedScene]

var items: Array = []             
var current_slot: int = 0           

func _ready():
	items.resize(3)

	for i in range(min(starting_item_scenes.size(), 3)):
		var item_scene = starting_item_scenes[i]
		if item_scene is PackedScene:
			var new_item = item_scene.instantiate()
			items[i] = new_item
			add_child(new_item)
			if i == current_slot:
				new_item.show()
				new_item.process_mode = Node.PROCESS_MODE_INHERIT
			else:
				new_item.hide()
				new_item.process_mode = Node.PROCESS_MODE_DISABLED

	RELAY.selected_slot_changed.emit.call_deferred(current_slot, items[current_slot])


func _input(event):
	if event.is_action_pressed("Inventory_01"):
		_set_selected_slot(0)
	elif event.is_action_pressed("Inventory_02"):
		_set_selected_slot(1)
	elif event.is_action_pressed("Inventory_03"):
		_set_selected_slot(2)

func _set_selected_slot(new_slot: int):
	if new_slot >= 0 and new_slot < items.size() and new_slot != current_slot:
		if items[current_slot] != null:
			items[current_slot].hide()
			items[current_slot].process_mode = Node.PROCESS_MODE_DISABLED

		current_slot = new_slot

		if items[current_slot] != null:
			items[current_slot].show()
			items[current_slot].process_mode = Node.PROCESS_MODE_INHERIT
			
		RELAY.selected_slot_changed.emit(current_slot, items[current_slot])
