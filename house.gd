class_name House extends StaticBody3D

@export var garbage_can: GarbageCan
@export var neighbour: Neighbour

func _ready() -> void:
	neighbour.garbage_can = garbage_can
