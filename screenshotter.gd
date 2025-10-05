extends Node3D

@onready var objects: Node3D = $Objects

func _ready() -> void:
	var main_window = get_window()
	main_window.size = Vector2i(512, 512)
	get_viewport().transparent_bg = true
	
	for child: RigidBody3D in objects.get_children():
		child.freeze = true
		child.visible = false
	
	await RenderingServer.frame_post_draw
	
	for child: RigidBody3D in objects.get_children():
		child.visible = true
		
		await RenderingServer.frame_post_draw
			
		var img: Image = get_viewport().get_texture().get_image()
		# Convert to RGBA8 format to preserve transparency when saving
		img.convert(Image.FORMAT_RGBA8)
		
		var save_path = "res://screenshots/" + child.name.to_snake_case() + ".png"
		var error = img.save_png(save_path)

		if error == OK:
			print("Thumbnail saved successfully to: " + save_path)
		else:
			print("Error saving thumbnail: " + str(error))
		
		child.visible = false
