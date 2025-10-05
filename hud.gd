class_name HUD extends Control

@onready var interaction_label: Label = $InteractionLabel
@onready var dialogue_box: DialogueBox = $DialogueBox
@onready var inventory_container: HBoxContainer = $Inventory
@export var crafter: Crafter

func _ready() -> void:
	dialogue_box.hide_dialogue_box()

func show_interaction_text(text: String) -> void:
	interaction_label.text = text

func hide_interaction_text() -> void:
	interaction_label.text = ""
