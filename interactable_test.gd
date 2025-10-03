extends Interactable

var done := false

func get_interaction_text() -> String:
	return "Press 'E' To interact"

func can_interact() -> bool:
	return !done
	
func interact(player: Player) -> void:
	print("interacted")
	player.inventory.add_item("Pussy")
	print(player.inventory.items)
	done = true
	
