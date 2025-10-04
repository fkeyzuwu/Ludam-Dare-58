class_name Neighbour extends StaticBody3D

@export var data: NeighbourData
@export var mesh_instance: MeshInstance3D
@export var collision_shape: CollisionShape3D

var garbage_can: GarbageCan

func _ready() -> void:
	mesh_instance.mesh = data.mesh_data.mesh.duplicate(true)
	mesh_instance.position.x = data.mesh_data.offset
	mesh_instance.mesh.surface_get_material(0).albedo_color = data.color
	
	#hide_neighbour()
	
func show_neighbour() -> void:
	mesh_instance.visible = true
	
func hide_neighbour() -> void:
	mesh_instance.visible = false
	
func throw_garbage() -> void:
	var garabge_item = data.throw_objects.pop_front()
	var garbage = garabge_item.scene.instantiate() as Garbage
	garbage.global_position = garbage_can.drop_point

func get_interaction_text() -> String:
	return "Press 'E' to talk to " + data.neighbour_name

func can_interact() -> bool:
	return !data.wanted_items.is_empty()

func interact(player: Player) -> void:
	if player.inventory.has(data.wanted_items.front()):
		var item = data.wanted_items.pop_front()
		player.inventory.remove(item)
		print("wow! you got my " + item.name)
		print("the next item i want is: + " + data.wanted_items.front())
	else:
		print("you dont have what i want lil ni")
		
func finish_interaction() -> void:
	pass
