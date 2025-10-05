class_name InventoryConatiner extends HBoxContainer

var items: Array[Item]
const ICON = preload("uid://nt6arbrxkqk1")

func add_item(item: Item) -> void:
	assert(items.size() < 10)
	items.append(item)
	var texture_rect = TextureRect.new()
	texture_rect.texture = ICON # = item.item_picture
	add_child(texture_rect)

func remove_item(item: Item) -> void:
	items.erase(item)
	for child: TextureRect in get_children():
		if child.texture == ICON: # == item.item_picture
			child.free()
			return
