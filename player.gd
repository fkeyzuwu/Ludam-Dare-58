class_name Player extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 3.5

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@export_range(0.1, 5.0, 0.01) var mouse_sensitivity := 1.0

@onready var camera: Camera3D = $Camera3D
@export var interaction_raycast: RayCast3D
@export var hud: HUD
@export var inventory: PlayerInventory

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var delta = get_process_delta_time()
		global_rotation.y -= event.relative.x * delta * mouse_sensitivity
		camera.global_rotation.x -= event.relative.y * delta * mouse_sensitivity
		camera.global_rotation_degrees.x = clampf(camera.global_rotation_degrees.x, -85, 85)
	elif event.is_action_pressed("quit"):
		get_tree().quit()

func _physics_process(delta: float) -> void:
	move(delta)
	try_interact()

func move(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func try_interact() -> void:
	if interaction_raycast.is_colliding():
		var interactable = interaction_raycast.get_collider() as Interactable
		if not interactable:
			push_error("COLLISION" + interactable + "IS NOT INTERACTABLE")
			hud.set_interaction_text("")
			return
		else:
			if interactable.can_interact():
				if Input.is_action_just_pressed(&"interact"):
					interactable.interact(self)
				else:
					hud.set_interaction_text(interactable.get_interaction_text())
			else:
				hud.set_interaction_text("")
	else:
		hud.set_interaction_text("")
