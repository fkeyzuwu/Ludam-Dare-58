class_name DialogueBox extends Panel

signal opened
signal closed

var current_sentences: Array[String]

@onready var dialogue_label: Label = $DialogueLabel
@onready var person_name_label: Label = $PersonNameLabel

func show_dialogue_box(person_name: String,text: String) -> void:
	visible = true
	dialogue_label.text = text
	person_name_label.text = person_name
	opened.emit()
	
func hide_dialogue_box() -> void:
	visible = false
	dialogue_label.text = ""
	person_name_label.text = ""
	closed.emit()

func continue_dialogue() -> void:
	if current_sentences.is_empty():
		hide_dialogue_box()
