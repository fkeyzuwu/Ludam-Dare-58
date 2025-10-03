class_name HUD extends Control

@onready var interaction_label: Label = $InteractionLabel

func set_interaction_text(text: String) -> void:
	interaction_label.text = text
