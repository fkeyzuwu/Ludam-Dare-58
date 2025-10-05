class_name PlayerInventory extends Node

var items: Array[Item]

var item_recipies: Dictionary
const ITEM_DIR = "res://items/"

func _ready() -> void:
	var files = DirAccess.get_files_at(ITEM_DIR)
	for i in range(files.size() - 1, -1, -1):
		if files[i].ends_with(".uid"):
			files.remove_at(i)
	
	for file in files:
		var item: Item = load(ITEM_DIR + file)
		item_recipies[item.components] = item

func add_item(item: Item) -> void:
	items.append(item)

func has(item: Item) -> bool:
	return items.has(item)

func remove(item: Item) -> void:
	items.erase(item)

func craft_item(components: Array[Item]) -> void:
	var new_item = item_recipies[components]
	if new_item:
		print("yay")
	else:
		print("boooo")
