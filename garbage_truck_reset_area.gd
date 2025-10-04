extends Area3D

func _on_body_entered(body: GarbageTruck) -> void:
	body.reset_to_start_position()
