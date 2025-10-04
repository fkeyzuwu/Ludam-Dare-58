class_name Neighbour extends StaticBody3D

@export var data: NeighbourData
@export var mesh_instance: MeshInstance3D
@export var collision_shape: CollisionShape3D

var garbage_can: GarbageCan

func _ready() -> void:
	mesh_instance.mesh = data.mesh_data.mesh.duplicate(true)
	mesh_instance.position.x = data.mesh_data.offset
	mesh_instance.mesh.material.albedo_color = data.color
	
	hide_neighbour()
	
func show_neighbour() -> void:
	mesh_instance.visible = true
	collision_shape.set_deferred(&"disabled", false)
	
func hide_neighbour() -> void:
	mesh_instance.visible = false
	collision_shape.set_deferred(&"disabled", true)
	
func throw_garbage() -> void:
	var garabge_item = data.throw_objects.pop_front()
	var garbage = garabge_item.scene.instantiate() as Garbage
	garbage.global_position = garbage_can.drop_point
