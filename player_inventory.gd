class_name PlayerInventory extends Node

var items: Array[Item]

func add_item(item: Item) -> void:
	items.append(item)
