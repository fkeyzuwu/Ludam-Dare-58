class_name Crafter extends VBoxContainer

@onready var player: Player = get_parent().get_parent()
@onready var inventory = player.inventory
@onready var inventory_container = player.hud.inventory_container
@onready var incorrect_recepie_label: Label = $IncorrectComboLabel

var items: Array[Item]

var label_tween: Tween

func _ready() -> void:
	incorrect_recepie_label.modulate.a = 0.0
	hide_crafter()

func show_crafter() -> void:
	show()

func hide_crafter() -> void:
	hide()

func _on_craft_button_pressed() -> void:
	inventory.craft_item(items)

func show_incorrect_recipie_text() -> void:
	if label_tween and label_tween.is_valid() and label_tween.is_running():
		label_tween.kill()
	
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans((Tween.TRANS_CUBIC))
	tween.tween_property(incorrect_recepie_label, ^"modulate:a", 0.0, 2.5).from(1.0)
