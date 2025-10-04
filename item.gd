class_name Item extends Resource

@export var item_name: String = "default"
@export_multiline var description: String
@export var scene: PackedScene
@export var components: Array[Item] = [null, null]
