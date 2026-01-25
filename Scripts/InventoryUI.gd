extends CanvasLayer

var STYLE_NORMAL 	= preload("res://Scenes/UI/slot_normal.tres")
var STYLE_SELECTED 	= preload("res://Scenes/UI/slot_selected.tres")

@onready var current_weapon = $ItemName
@onready var item_type_label = $ItemType
@onready var item_image = $ItemImage

@onready var slots = [
	$MarginContainer/HBoxContainer/Slot1,
	$MarginContainer/HBoxContainer/Slot2,
	$MarginContainer/HBoxContainer/Slot3
]

var size_tween

func _ready():
	RELAY.selected_slot_changed.connect(_on_selected_slot_changed)

func _on_selected_slot_changed(slot_index: int, item_node: Node):
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

	if item_node and item_node.has_method("GetGunData"):
		var gun_data = item_node.GetGunData()
		if gun_data and gun_data.ui_position is PackedScene:
			var ui_instance = gun_data.ui_position.instantiate()

			var source_name = ui_instance.find_child("ItemName")
			var source_type = ui_instance.find_child("ItemType")
			var source_image = ui_instance.find_child("ItemImage")

			if source_name and source_type and source_image:
				# --- Update content instantly ---
				current_weapon.text = source_name.text
				item_type_label.text = source_type.text
				item_image.texture = source_image.texture
				item_image.scale = source_image.scale

				# --- Animate positions ---
				size_tween.tween_property(current_weapon, "position", source_name.position, 0.6)
				size_tween.tween_property(item_type_label, "position", source_type.position, 0.6)
				size_tween.tween_property(item_image, "position", source_image.position, 0.6)

				# --- Animate fade in ---
				size_tween.tween_property(current_weapon, "modulate:a", 1.0, 0.5)
				size_tween.tween_property(item_type_label, "modulate:a", 1.0, 0.5)
				size_tween.tween_property(item_image, "modulate:a", 1.0, 0.5)

			ui_instance.queue_free()
	else:
		# --- Animate fade out for empty slot ---
		size_tween.tween_property(current_weapon, "modulate:a", 0.0, 0.5)
		size_tween.tween_property(item_type_label, "modulate:a", 0.0, 0.5)
		size_tween.tween_property(item_image, "modulate:a", 0.0, 0.5)
