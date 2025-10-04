class_name Garbage extends RigidBody3D

@export var garbage_name: String

func get_interaction_text() -> String:
	return "Press 'E' to pickup " + garbage_name

func can_interact() -> bool:
	return true
	
func interact(player: Player) -> void:
	player.inventory.add_item(get_script().get_global_name())
	print(player.inventory.items)
	queue_free()
	
