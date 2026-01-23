extends CanvasLayer

var STYLE_NORMAL 	= preload("res://Scenes/UI/slot_normal.tres")
var STYLE_SELECTED 	= preload("res://Scenes/UI/slot_selected.tres")

@onready var current_weapon = $ItemName

@onready var slots = [
	$MarginContainer/HBoxContainer/Slot1,
	$MarginContainer/HBoxContainer/Slot2,
	$MarginContainer/HBoxContainer/Slot3
]

var size_tween

func _ready():
	RELAY.selected_slot_changed.connect(_on_selected_slot_changed)

func _on_selected_slot_changed(slot_index: int, item_node):
	if size_tween and size_tween.is_valid():
		size_tween.kill()

	size_tween = create_tween().set_parallel().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	for i in range(slots.size()):
		if i == slot_index:
			slots[i].add_theme_stylebox_override("panel", STYLE_SELECTED)
			size_tween.tween_property(slots[i], "custom_minimum_size:x", 120, 0.7)
		else:
			slots[i].add_theme_stylebox_override("panel", STYLE_NORMAL)
			size_tween.tween_property(slots[i], "custom_minimum_size:x", 60, 0.7)

	
	current_weapon.text = item_node.name if item_node else ""
 
func update_inventory_visuals(items: Array):
	for i in range(slots.size()):
		var texture_rect = slots[i].get_node("TextureRect")
		if items[i] and items[i].has("texture"): 
			texture_rect.texture = items[i].texture
		else:
			texture_rect.texture = null
