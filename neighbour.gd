class_name Neighbour extends StaticBody3D

@export var data: NeighbourData
@export var mesh_instance: MeshInstance3D
@export var collision_shape: CollisionShape3D

var garbage_can: GarbageCan
var initial_interaction := false

func _ready() -> void:
	mesh_instance.mesh = data.mesh_data.mesh.duplicate(true)
	mesh_instance.position.x = data.mesh_data.offset
	mesh_instance.mesh.surface_get_material(0).albedo_color = data.color
	
	name = data.neighbour_name
	hide_neighbour()
	throw_garbage()
	
func show_neighbour() -> void:
	mesh_instance.visible = true
	
func hide_neighbour() -> void:
	mesh_instance.visible = false
	
func throw_garbage() -> void:
	await get_tree().create_timer(randf_range(5.0, 30.0)).timeout
	var garabge_item = data.throw_objects.pop_front() as Item
	if garabge_item:
		var item_scene: PackedScene = load(garabge_item.scene)
		var garbage = item_scene.instantiate() as RigidBody3D
		garbage_can.add_child(garbage)
		var pos = garbage_can.drop_point.global_position
		pos.x += randf_range(-0.3, 0.3)
		pos.z += randf_range(-0.3, 0.3)
		garbage.global_position = pos
		garbage.rotation_degrees.y = randf_range(0, 360)
		for child in garbage.get_children():
			if child is Garbage:
				child.picked_up.connect(func(_garbage: Garbage): throw_garbage())
				break

func get_interaction_text() -> String:
	return "Press 'E' to talk to " + data.neighbour_name

func can_interact() -> bool:
	return !data.wanted_items.is_empty()

func interact(player: Player) -> void:
	show_neighbour()
	player.hud.hide_interaction_text()
	
	if not initial_interaction:
		var dialogue_data = data.dialogues.front()
		var dialogue = dialogue_data.initial_dialogue.duplicate()
		player.hud.dialogue_box.show_dialogue_box(data.neighbour_name, dialogue)
		initial_interaction = true
	else:
		if player.inventory.has(data.wanted_items.front()):
			var item = data.wanted_items.pop_front()
			player.inventory.remove(item)
			var old_dialogue_data = data.dialogues.pop_front()
			var new_dialogue_data = data.dialogues.front() if not data.dialogues.is_empty() else null
			var dialogue = old_dialogue_data.accept_dialogue
			if new_dialogue_data:
				dialogue += new_dialogue_data.initial_dialogue
			player.hud.dialogue_box.show_dialogue_box(data.neighbour_name, dialogue)
		else:
			var dialogue_data = data.dialogues.front()
			var dialogue = dialogue_data.decline_dialogue.duplicate()
			player.hud.dialogue_box.show_dialogue_box(data.neighbour_name, dialogue)
		
	await player.hud.dialogue_box.closed
	hide_neighbour()
		
func finish_interaction() -> void:
	pass
