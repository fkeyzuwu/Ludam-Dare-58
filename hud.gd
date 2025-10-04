class_name HUD extends Control

@onready var interaction_label: Label = $InteractionLabel
@onready var dialogue_label: Label = $DialogueBox/DialogueLabel
@onready var dialogue_box: Panel = $DialogueBox

func _ready() -> void:
	hide_dialogue_box()

func show_interaction_text(text: String) -> void:
	interaction_label.text = text

func hide_interaction_text() -> void:
	interaction_label.text = ""

func show_dialogue_box(text: String) -> void:
	dialogue_box.visible = true
	dialogue_label.text = text
	
func hide_dialogue_box() -> void:
	dialogue_label.text = ""
	dialogue_box.visible = false
