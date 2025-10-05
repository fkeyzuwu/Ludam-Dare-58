class_name DialogueBox extends Panel

signal opened
signal closed

var current_sentences: Array[String]

@onready var dialogue_label: Label = $DialogueLabel
@onready var person_name_label: Label = $PersonNameLabel

@export var screen_blocker: ColorRect

func show_dialogue_box(person_name: String, dialogue: Array[String]) -> void:
	visible = true
	current_sentences = dialogue
	person_name_label.text = person_name
	opened.emit()
	screen_blocker.mouse_filter = Control.MOUSE_FILTER_STOP
	continue_dialogue()
	
func hide_dialogue_box() -> void:
	visible = false
	dialogue_label.text = ""
	person_name_label.text = ""
	screen_blocker.mouse_filter = Control.MOUSE_FILTER_IGNORE
	closed.emit()

func continue_dialogue() -> void:
	if current_sentences.is_empty():
		hide_dialogue_box()
	else:
		dialogue_label.text = current_sentences.pop_front()
