extends Node3D

var rigidbody: RigidBody3D

func _ready() -> void:
	for child in get_children():
		if child is RigidBody3D:
			rigidbody = child
			break
	
	rigidbody.freeze = true

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed(&"ui_filedialog_show_hidden"):
		await RenderingServer.frame_post_draw
		
		var img: Image = get_viewport().get_texture().get_image()
		#img.crop(512, 512)
		# Convert to RGBA8 format to preserve transparency when saving
		img.convert(Image.FORMAT_RGBA8)
		
		var save_path = "res://screenshots/" + rigidbody.name.to_snake_case() + ".png"
		var error = img.save_png(save_path)

		if error == OK:
			print("Thumbnail saved successfully to: " + save_path)
		else:
			print("Error saving thumbnail: " + str(error))
