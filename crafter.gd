class_name Crafter extends VBoxContainer

@onready var player: Player = get_parent().get_parent()
@onready var inventory = player.inventory
@onready var inventory_container = player.hud.inventory_container
@onready var incorrect_recepie_label: Label = $IncorrectComboLabel
@onready var craft_button: Button = $CraftButton

var inventory_items: Array[InventoryItem] = []
@export var item_slots: Array[TextureRect]

var label_tween: Tween

func _ready() -> void:
	incorrect_recepie_label.modulate.a = 0.0
	hide_crafter()
	craft_button.disabled = true

func show_crafter() -> void:
	show()

func hide_crafter() -> void:
	hide()

func _on_craft_button_pressed() -> void:
	if inventory_items.size() == 2:
		var items = [inventory_items[0].item, inventory_items[1].item]
		inventory.craft_item(items)

func push_inventory_item(inventory_item: InventoryItem) -> void:
	assert(inventory_items.size() < 2)
	inventory_items.push_back(inventory_item)
	inventory_item.reparent(item_slots[inventory_items.size() - 1])
	
	if inventory_items.size() == 2:
		craft_button.disabled = false

func return_inventory_item(inventory_item: InventoryItem) -> void:
	inventory_items.erase(inventory_item)
	inventory_item.reparent(inventory_container)
	craft_button.disabled = true

func return_crafting_slots() -> void:
	for inventory_item in inventory_items:
		inventory_item.reparent(inventory_container)
		craft_button.disabled = true
	
	inventory_items.clear()
	
func show_incorrect_recipie_text() -> void:
	if label_tween and label_tween.is_valid() and label_tween.is_running():
		label_tween.kill()
	
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans((Tween.TRANS_CUBIC))
	tween.tween_property(incorrect_recepie_label, ^"modulate:a", 0.0, 2.5).from(1.0)
