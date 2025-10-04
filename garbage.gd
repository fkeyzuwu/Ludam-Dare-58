class_name Garbage extends Area3D

@export var item: Item

func get_interaction_text() -> String:
	return "Press 'E' to pickup " + item.item_name

func can_interact() -> bool:
	return true
	
func interact(player: Player) -> void:
	player.inventory.add_item(item)
	get_parent().queue_free()
