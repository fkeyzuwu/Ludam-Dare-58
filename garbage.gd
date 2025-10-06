class_name Garbage extends Area3D

@export var item: Item
signal picked_up(garbage: Garbage)

func get_interaction_text() -> String:
	return "Press 'E' to pickup " + item.item_name

func can_interact() -> bool:
	return true
	
func interact(player: Player) -> void:
	if player.inventory.items.size() < player.inventory.MAX_INVENTORY_SIZE:
		player.inventory.add_item(item)
		picked_up.emit(self)
		get_parent().queue_free()
	else:
		player.hud.dialogue_box.show_dialogue_box("tumi", ["i can't carry this many items... im smol boi ;-;"])
