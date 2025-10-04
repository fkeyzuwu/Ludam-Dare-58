class_name HUD extends Control

@onready var interaction_label: Label = $InteractionLabel

func show_interaction_text(text: String) -> void:
	interaction_label.text = text

func hide_interaction_text() -> void:
	interaction_label.text = ""
