extends CanvasLayer

var STYLE_NORMAL 	= preload("res://Scenes/UI/slot_normal.tres")
var STYLE_SELECTED 	= preload("res://Scenes/UI/slot_selected.tres")

@onready var slots = [
	$MarginContainer/HBoxContainer/Slot1,
	$MarginContainer/HBoxContainer/Slot2,
	$MarginContainer/HBoxContainer/Slot3
]

func _ready():
	RELAY.selected_slot_changed.connect(_on_selected_slot_changed)

func _on_selected_slot_changed(slot_index: int):
	for i in range(slots.size()):
		if i == slot_index:
			slots[i].add_theme_stylebox_override("panel", STYLE_SELECTED)
		else:
			slots[i].add_theme_stylebox_override("panel", STYLE_NORMAL)

func update_inventory_visuals(items: Array):
	for i in range(slots.size()):
		var texture_rect = slots[i].get_node("TextureRect")
		if items[i] and items[i].has("texture"): 
			texture_rect.texture = items[i].texture
		else:
			texture_rect.texture = null
