class_name PlayerInventory extends Node

var items: Array[Item]
@onready var player: Player = get_parent()
@onready var dialogue_box: DialogueBox = player.hud.dialogue_box
@onready var inventory_container: InventoryConatiner = player.hud.inventory_container
@onready var crafter: Crafter = player.hud.crafter

var item_recipies: Dictionary
@export_file("*.tres") var item_file_paths: Array[String]
const MAX_INVENTORY_SIZE = 10

func _ready() -> void:
	for file in item_file_paths:
		var item: Item = load(file)
		if item.components.size() > 0:
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
	var components2 = components.duplicate()
	components2.reverse()
	
	if item_recipies.has(components):
		var new_item = item_recipies[components] as Item
		dialogue_box.show_dialogue_box("tuni", [new_item.description])
		for component in components.duplicate():
			remove(component)
			
		add_item(new_item)
		AudioManager.play_crafted_item_sound()
	elif item_recipies.has(components2):
		var new_item = item_recipies[components2] as Item
		dialogue_box.show_dialogue_box("tuni", [new_item.description])
		for component in components2.duplicate():
			remove(component)
			
		add_item(new_item)
		AudioManager.play_crafted_item_sound()
	else:
		crafter.show_incorrect_recipie_text()
