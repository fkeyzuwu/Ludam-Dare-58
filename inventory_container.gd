class_name InventoryConatiner extends HBoxContainer

var items: Array[Item]
const ICON = preload("uid://nt6arbrxkqk1")
const INVENTORY_ITEM = preload("uid://dvwt02kgkrrwp")
@onready var crafter: Crafter = (get_parent() as HUD).crafter

func add_item(item: Item) -> void:
	assert(items.size() < PlayerInventory.MAX_INVENTORY_SIZE)
	items.append(item)
	var inventory_item = INVENTORY_ITEM.instantiate() as InventoryItem
	inventory_item.item = item
	inventory_item.texture = ICON # TODO: = item.item_picture once we have pictures
	add_child(inventory_item)
	inventory_item.inventory_item_pressed.connect(_on_inventory_item_pressed)

func remove_item(item: Item) -> void:
	items.erase(item)
	for inventory_item: InventoryItem in get_children():
		if inventory_item.item == item:
			inventory_item.queue_free()
			return

func _on_inventory_item_pressed(inventory_item: InventoryItem) -> void:
	if crafter.inventory_items.size() < 2:
		if not inventory_item.in_crafting:
			crafter.push_inventory_item(inventory_item)
		else:
			crafter.return_inventory_item(inventory_item)
