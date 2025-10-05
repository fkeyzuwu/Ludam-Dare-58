class_name PlayerInventory extends Node

var items: Array[Item]
@onready var player: Player = get_parent()
@onready var dialogue_box: DialogueBox = player.hud.dialogue_box
@onready var inventory_container: InventoryConatiner = player.hud.inventory_container

var item_recipies: Dictionary
const ITEM_DIR = "res://items/"
const MAX_INVENTORY_SIZE = 10

func _ready() -> void:
	var files = DirAccess.get_files_at(ITEM_DIR)
	for i in range(files.size() - 1, -1, -1):
		if files[i].ends_with(".uid"):
			files.remove_at(i)
	
	for file in files:
		var item: Item = load(ITEM_DIR + file)
		if item.components.size() >= 0:
			item_recipies[item.components] = item

func add_item(item: Item) -> void:
	items.append(item)
	inventory_container.add_item(item)

func has(item: Item) -> bool:
	return items.has(item)

func remove(item: Item) -> void:
	items.erase(item)
	inventory_container.remove_item(item)

func craft_item(components: Array[Item]) -> void:
	if item_recipies.has(components):
		var new_item = item_recipies[components] as Item
		dialogue_box.show_dialogue_box("tuni", [new_item.description])
		for component in components.duplicate():
			remove(component)
			
		add_item(new_item)
	else:
		print("boooo")
