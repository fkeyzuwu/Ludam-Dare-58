class_name InventoryItem extends TextureRect

var item: Item
var in_crafting := false

signal inventory_item_pressed(inventory_item: InventoryItem)

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"mouse_left"):
		inventory_item_pressed.emit(self)
