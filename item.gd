class_name Item extends Resource

@export var item_name: String = "default"
@export_multiline var description: String
@export_file("*.tscn") var scene: String
@export var components: Array[Item] = []
@export var item_picture: Texture2D
