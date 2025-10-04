class_name PlayerInventory extends Node

var items: Array[Item]

func add_item(item: Item) -> void:
	items.append(item)

func has(item: Item) -> bool:
	return items.has(item)

func remove(item: Item) -> void:
	items.erase(item)
