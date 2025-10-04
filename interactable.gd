@abstract
class_name Interactable extends CollisionObject3D

@abstract
func get_interaction_text() -> String

@abstract
func can_interact() -> bool

@abstract
func interact(player: Player) -> void
